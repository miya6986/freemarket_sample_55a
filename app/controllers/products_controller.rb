class ProductsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy,:buy,:item]
  before_action :set_product, only: [:show, :buy, :destroy, :item, :edit]
  before_action :product_seller?, only: :item

  def index
    @products = Product.order('created_at DESC').includes(:images)
  end

  def new
    @product = Product.new
    @product.images.build
    @product.build_brand
    @parents = Category.where(ancestry: nil)
  end

  def get_category_children
    respond_to do |format| 
      format.html
      format.json do
        @children = Category.find(params[:parent_id]).children
      end
    end
  end

  def get_category_grandchildren
    @grandchildren = Category.find("#{params[:child_id]}").children
  end

  def get_size
    selected_childid = Category.find("#{params[:grandchild_id]}").parent
    if category_with_size = selected_childid.sizes[0]
      @sizes = category_with_size.children
    end
  end

  def create
    @product = Product.new(product_params)
    @product.brand.delete
    if params[:product][:brand_attributes][:name].present?
      brand_name = params[:product][:brand_attributes][:name] 
      brand = Brand.where(name: brand_name).first_or_create
      @product[:brand_id] = brand.id
    end
    if @product.save
      redirect_to users_path, notice: "商品を出品しました"
    else 
      render 'new'
    end
  end
  
  def show
    @image = @product.images.first.name.to_s
    @category = []
    @category = @product.categories.pluck(:name)
  end

  def edit
    @product = Product.find(params[:id])
    @parent = @product.categories[0]
    @child = @product.categories[1]
    @grandchild = @product.categories[2]
    @parents = Category.where(ancestry: nil)
    @children = Category.where(ancestry: @child.ancestry)
    @grandchildren = Category.where(ancestry: @grandchild.ancestry)
    @size = @child.sizes[0] if @child.sizes[0]
    @sizes = @size.children if @size
  end

  def update
    @product = Product.find(params[:id])
    @parents = Category.where(ancestry: nil)
    if params[:product].keys.include?("image") || params[:product].keys.include?("images_attributes") 
      if @product.valid?
        if params[:product].keys.include?("image")
          posted_image_ids = params[:product][:image].values 
          @product.images.ids.each do |img_id|
            Image.find(img_id).destroy unless posted_image_ids.include?("#{img_id}")
          end
        end
        @product.update(product_params)
        @size = @product.categories[1].sizes[0]
        @product.update(size: nil) unless @size
        redirect_to users_path, notice: "商品を更新しました"
      else
        render 'edit'
      end
    else
      redirect_back(fallback_location: root_path,flash: {success: '画像がありません'})
    end
  end

  def buy
    redirect_back(fallback_location: root_path) unless @product.buyer.blank?
    @address = current_user.address
    @address_full = "#{@address.prefecture.name}#{@address.city_name}#{@address.address_number}#{@address.building_name}"
    @full_name = "#{@address.firstname} #{@address.lastname}"
    @postalcode = @address.postalcode
    @card = Creditcard.where(user_id: current_user.id).first if Creditcard.where(user_id: current_user.id).present?
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_info = customer.cards.retrieve(customer.default_card)
      @card_brand = @card_info.brand
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 
      case @card_brand
      when "Visa"
        @card_image = "visa.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master-card.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "dinersclub.svg"
      when "Discover"
        @card_image = "discover.svg"
      end
    end
  end

  def search
    @products = Product.order('created_at DESC').includes(:images)
  end
    
  def destroy
    if @product.seller == current_user
      if @product.destroy
        redirect_to my_selling_products_users_path, notice: "商品を削除しました" and return
      else
        redirect_to item_product_path(params[:id]) and return
      end
    else
      redirect_to root_path and return
    end
  end

  def item
    @category = []
    @category = @product.categories.pluck(:name)
  end
    
  private


  def product_params
    params.require(:product).permit(
      :name,
      :description,
      :size,
      :condition,
      :postage,
      :shipping_method,
      :prefecture_id,
      :shipping_days,
      :price,
      images_attributes: [:name, :id],
      brand_attributes: [:name],
      category_ids: []
    )
    .merge(seller_id: current_user.id)
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_seller?
    redirect_to root_path unless @product.seller == current_user 
  end
  
end
