class ProductsController < ApplicationController
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
    if @product.save
      redirect_to users_path, notice: "商品を出品しました"
    else 
      render 'new'
    end
  end
  
  def show
    @product = Product.find(params[:id])
    @image = @product.images.first.name.to_s
    @category = []
    @category = @product.categories.pluck(:name)
  end

  def buy
    @product = Product.find(params[:id])
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
    @parents = Category.where(ancestry: nil)
    @sizes = Size.where(ancestry: nil)
    if params[:q].present?
      @q = Product.ransack(search_params)
      @search_products = @q.result(distinct: true).page(params[:page]).per(8).includes(:images)
    end
  end
    
  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to my_selling_products_users_path, notice: "商品を削除しました"
    else
      render :item, collection: @product
    end
  end

  def item
    @category = []
    @product = Product.find(params[:id])
    @price = (@product.price * 1.08).ceil
    @category = @product.categories.pluck(:name)
    @seller = @product.seller
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
      images_attributes: [:name],
      brand_attributes: [:name],
      category_ids: []
    )
    .merge(seller_id: current_user.id)
  end

  def search_params
    params.require(:q).permit(
      :name_or_description_cont,
      # :sorts,
      :price_gteq,
      :price_lteq,
      :brand_name_cont,
      categories_sizes_id_eq: [],
      categories_id_eq: [],
      condition_eq_any: [],
      postage_eq_any: [],
    ) if params[:q].present?
  end
  
  def initilize_ransack_variable
    # 詳細検索用インスタンス変数
    @condition_list = Product.condition_check_list
    @postage_list = Product.postage_check_list
    @parents = Category.where(ancestry: nil)
    @sizes = Size.where(ancestry: nil)
  end

end
