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
    if params[:q].present?
    # 検索フォームからアクセスした時の処理
      @search = Product.ransack(search_params)
      @products = @search.result.includes(:images)
    else
    # 検索フォーム以外からアクセスした時の処理
      params[:q] = { sorts: 'id desc' }
      @search = Product.ransack()
      @products = Product.all.includes(:images)
    end
  end

  private
  def search_params
    params.require(:q).permit(:sorts)
  end

  
end
