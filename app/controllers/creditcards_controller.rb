class CreditcardsController < ApplicationController
  require "payjp"

  def index
  end

  def new
    card = Creditcard.where(user_id: current_user.id).first
    redirect_to action: "index" if card.exists?    
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjp-token'].blank?
      redirect_to action: "new"
    else
      customer = Payjp::Customer.create(
      email: current_user.email,
      card: params['payjp-token'],
      metadata: {user_id: current_user.id}
      )
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id, card_id: customer.default_card)
      if @card.save
        redirect_to action: "index"
      else
        redirect_to action: "create"
      end
    end
  end

  def show
    card = Creditcard.where(user_id: current_user.id).first
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(card.customer_id)
    @card_info = customer.cards.retrieve(card.card_id)
  end


  def destroy     
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    @card = Creditcard.where(user_id: current_user.id).first
    customer = Payjp::Customer.retrieve(card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end
end
