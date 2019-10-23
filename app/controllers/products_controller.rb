class ProductsController < ApplicationController
  def index
    @products = Product.order('id DESC').limit(10)
  end

  def new
  end

  def buy
  end
  
end
