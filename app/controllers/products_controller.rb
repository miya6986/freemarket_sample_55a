class ProductsController < ApplicationController
  def index
  end

  def new
  end

  def buy
  end

  def show
    @product = Product.find(params[:id])
    @image = @product.images.first.name.to_s
  end
  
end
