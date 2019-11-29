class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :set_search
  before_action :set_parent_categories
  before_action :set_brand

  def set_search
    @q = Product.ransack(params[:q])
  end

  def set_parent_categories 
    @categories = Category.where(ancestry:nil)
  end

  def set_brand 
    @brands = Brand.all
  end

  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials.basic_auth[:user] && password == Rails.application.credentials.basic_auth[:password]
    end
  end
end
