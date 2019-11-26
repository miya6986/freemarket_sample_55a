class UsersController < ApplicationController
  def index  
  end
  
  def edit
  end
  
  def user_identification
  end

  def selling_products
    @products = current_user.selling_products.limit(15).order(id: "DESC")
  end

  def logout_page
  end

end
