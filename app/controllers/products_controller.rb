class ProductsController < ApplicationController
  def index
  end

  def new
  end

  def buy
  end

  def destroy
    @product = Product.find(products_params[:id])
  end

  def item
    @product = Product.find(params[:id])
    @category = @product.category_ids
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
