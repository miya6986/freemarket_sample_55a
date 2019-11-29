class ApplicationController < ActionController::Base
  before_action :basic_auth, if: :production?
  protect_from_forgery with: :exception
  before_action :set_search

  def set_search
    @q = Product.ransack(params[:q])
    @search_products = @q.result(distinct: true).page(params[:page]).per(8).includes(:images)
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
