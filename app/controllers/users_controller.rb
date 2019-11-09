class UsersController < ApplicationController
  def index  
  end
  
  def edit
  end

  def logout
  end
  
  def user_identification
  end

  def my_selling_products
    @user = User.find(current_user.id)
    @products = @user.products.includes(:product).where(seller_id: current_user.id).order(id: "DESC").limit(15)
  end

end
