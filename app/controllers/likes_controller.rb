class LikesController < ApplicationController
  def index
    @likes = current_user.likes
  end

  def create
    @like = Like.create(user_id: current_user.id, product_id: @product.id)
    redirect_back(fallback_location: product_path(@product))
  end

  def destroy
    @like = Like.find_by(user_id: current_user.id, product_id: @product.id)
    @like.destroy
    redirect_back(fallback_location: product_path(@product))
  end

  private
  def set_product
    @product = Product.find(params[:Product_id])
  end 
end
