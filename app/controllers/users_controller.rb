class UsersController < ApplicationController
  before_action :authenticate_user! ,except: [:show]

  def index  
  end
  
  def edit
  end

  def update
    if request.referer&.include?("users/identification")
      if current_user.update(user_params)
        redirect_to identification_users_path
      else
        render "identification"
      end
    else
      if current_user.update(edit_params)
        redirect_to edit_user_path
      else
        render "edit"
      end
    end
  end
  
  def identification
  end

  def selling_products
    @products = current_user.selling_products.limit(15).order(id: "DESC").includes(:images, :seller, :categories, :brand, :likes)
  end

  def sold_products
    @products = current_user.sold_products.limit(15).order(id: "DESC").includes(:images, :seller, :buyer, :categories, :brand, :likes)
  end
  def bought_products
    @products = current_user.bought_products.limit(15).order(id: "DESC").includes(:images, :seller, :buyer, :categories, :brand, :likes)
  end

  def logout_page
  end

  private
  def user_params
    params.require(:user).permit(
      :prefecture_id,
      :postalcode,
      :city_name,
      :address_number,
      :building_name,
      :phone_number,
    )
  end

  def edit_params
    params.require(:user).permit(
      :nickname,
      :profile,
    )
  end
end

