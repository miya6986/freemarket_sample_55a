class CreditcardsController < ApplicationController
  def index
  end

  def show
    creditcard = Creditcard.where(user_id: current_user.id)
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    
  end

  def destroy    
  end
end
