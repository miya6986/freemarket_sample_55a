class BrandController < ApplicationController
  def index
  end

  def show
  end

  def search
    @brands = Brand.where('name LIKE(?)', "%#{params[:keyword]}%").limit(20)
    respond_to do |format|
      format.html
      format.json
    end
  end
end
