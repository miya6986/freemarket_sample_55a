class ProductsController < ApplicationController
  before_action :set_product, except: [:index, :new]
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
  end

  def edit
    @product = Product.find(params[:id])
    @parents = Category.where(ancestry: nil)
  end

  def update
    @parents = Category.where(ancestry: nil)
    if @product.update(product_params)
      redirect_to users_path, notice: "商品を更新しました"
    else 
      render 'new'
    end
  end

  def buy
  end

  def search
    @products = Product.order('created_at DESC').includes(:images)
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
  def set_product
    @product = Product.find(params[:id])
  end

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
  
end
