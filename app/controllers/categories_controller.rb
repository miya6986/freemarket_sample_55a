class CategoriesController < ApplicationController
  def index
  end

  def show
    @category = Category.find(params[:id])
    @products = @category.products.page(params[:page]).per(10).includes(:seller,:images)
  end
end
