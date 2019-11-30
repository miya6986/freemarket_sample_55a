class BrandController < ApplicationController
  def index
  end

  def show
    @brand = Brand.find(params[:id])
    @products = @brand.products.order(id: "desc").page(params[:page]).per(10).includes(:seller,:images)
  end

  def search
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%").limit(20)
    respond_to do |format|
      format.html
      format.json
    end
  end
end
