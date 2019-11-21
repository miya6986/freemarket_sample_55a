class UsersController < ApplicationController
  before_action :authenticate_user! ,except: [:show]

  def index  
  end
  
  def edit
    @user = User.find(params[:id])
  end

  def update
    current_user.update(user_params)
    redirect_to edit_user_path
  end
  
  def user_identification
  end

  def my_selling_products
    @products = current_user.selling_products.limit(15).order(id: "DESC")
  end

  def logout_page
  end

  private
  def user_params
    params.require(:user).permit(:nickname, :profile)
  end
end

