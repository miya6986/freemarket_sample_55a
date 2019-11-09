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
      redirect_to user_path, notice: "商品を削除しました"
    else
      render :item, collection: @product
    end
  end

  def item
    @category = []
    @product = Product.find(params[:id])
    @price = @product.price * 1.08
    @product.categories.each do |category|
      @category << category.name
    end
    # @buyer = @product.user.find(products_params[:buyer_id])
    # @seller = @product.user.find(products_params[:seller_id])
  end

  private

  def products_params
    params.require(:products).permit( :id,
                                      :name,
                                      :text,
                                      :size,
                                      :condition,
                                      :postage,
                                      :shipping_method,
                                      :prefecture_id,
                                      :shipping_days,
                                      :price,
                                      :buyer_id,
                                      :seller_id,
                                      :brand_id,
                                      :category_id,
                                      :user_id
                                    )
  end

end
