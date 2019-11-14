class ProductsController < ApplicationController
  def index
    @products = Product.includes(:seller,:images).order('created_at DESC')
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

  def buy
  end

  def show
    # トップページから詳細ページへの移管を行う
    @product = Product.find(params[:id])
    # 出品者
    @seller = @product.seller.nickname
    # アイテム名
    @name = @product.name
    # 商品画像
    @image = @product.images.first.name.to_s
    # カテゴリー
    # @category = Category.all.order("id").limit(3)
    # ブランド
    @brand = @product.brand.name
    # 状態
    @condition = @product.condition
    # 配送料の負担
    @postage = @product.postage
    # 配送の方法
    @shipping_method = @product.shipping_method
    # 配送元の地域
    # @prefecture = @product.prefecture_id
    # 配送の目安
    @shipping_days = @product.shipping_days
    # 値段
    @price = @product.price
    # 商品の説明
    @detail = @product.description
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
