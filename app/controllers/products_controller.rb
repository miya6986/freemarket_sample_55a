class ProductsController < ApplicationController
  def index
    @products = Product.order('created_at DESC').includes(:images)
  end

  def new
  end

  def buy
  end

  def search
    @products = Product.order('created_at DESC').includes(:images)
    @search_name = params[:q]['name_cont']
  end
  
end
