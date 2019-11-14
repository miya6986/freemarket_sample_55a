class ProductsController < ApplicationController
  def index
  end

  def new
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
  
end
