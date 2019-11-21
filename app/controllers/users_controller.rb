class UsersController < ApplicationController
  before_action :authenticate_user! ,except: [:show]

  def index  
  end
  
  def edit
    @user = current_user
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
    @user = current_user
  end

  def my_selling_products
    @products = current_user.selling_products.limit(15).order(id: "DESC")
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

