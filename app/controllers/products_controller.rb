class ProductsController < ApplicationController
  def index
    @products = Product.order('created_at DESC').limit(10).includes(:images)
  end

  def new
  end

  def buy
  end
  
end
