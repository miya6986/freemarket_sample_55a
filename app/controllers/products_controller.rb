class ProductsController < ApplicationController
  def index
    @products = Product.order('created_at DESC').includes(:images)
  end

  def new
  end

  def buy
  end

  def search
  end
  
end
