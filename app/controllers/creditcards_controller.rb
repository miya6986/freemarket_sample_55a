class CreditcardsController < ApplicationController
  require "payjp"

  def index
  end

  def show
    creditcard = Creditcard.where(user_id: current_user.id).first
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(creditcard.customer_id)
    @card_info = customer.cards.retrieve(creditcard.card_id)
  end

  def destroy    
  end
end
