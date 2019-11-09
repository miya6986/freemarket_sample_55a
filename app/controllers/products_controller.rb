class ProductsController < ApplicationController
  def index
  end

  def new
  end

  def buy
  end

  def destroy
    @product = Product.find(params[:id])
    if @product.destroy
      redirect_to users_path, notice: "商品を削除しました"
    else
      render :item, collection: @product
    end
  end

  def item
    @category = []
    @product = Product.find(params[:id])
    @price = (@product.price * 1.08).ceil
    @product.categories.each do |category|
      @category << category.name
    end
    @seller = @product.seller
  end
end
