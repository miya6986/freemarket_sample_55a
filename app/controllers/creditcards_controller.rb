class CreditcardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def index
    if @card.present?
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      customer = Payjp::Customer.retrieve(@card.customer_id)
      @card_info = customer.cards.retrieve(customer.default_card)
      @card_brand = @card_info.brand
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 
      case @card_brand
      when "Visa"
        @card_image = "visa.svg"
      when "JCB"
        @card_image = "jcb.svg"
      when "MasterCard"
        @card_image = "master-card.svg"
      when "American Express"
        @card_image = "american_express.svg"
      when "Diners Club"
        @card_image = "dinersclub.svg"
      when "Discover"
        @card_image = "discover.svg"
      end
    end
  end

  def new
    @card = Creditcard.where(user_id: current_user.id).first
    redirect_to action: "index" if @card.present?    
  end

  def create
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    if params['payjpToken'].blank?
      render "new"
    else
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjpToken'],
        metadata: {user_id: current_user.id}
      )
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id)
        if @card.save
          redirect_to action: "index", notice:"支払い情報の登録が完了しました"
        else
          render 'new'
        end
    end
  end

  def destroy     
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    customer = Payjp::Customer.retrieve(@card.customer_id)
    customer.delete
    if @card.destroy
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  def buy
    @product = Product.find(params[:product_id])
    if @card.blank?
      redirect_to action: "new"
      flash[:alert] = '購入にはクレジットカード登録が必要です'
    elsif @product.buyer.present?
      redirect_back(fallback_location: root_path)
    else
      # = link_to buy_creditcards_path(product_id: @product.id)のproduct_idを使って@productを定義
      # Payjpの秘密鍵を設定
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      # Payjpの支払い処理:Payjp::Charge.createを生成。
      Payjp::Charge.create(
      amount: @product.price, #支払金額
      customer: @card.customer_id, #顧客ID
      currency: 'jpy', #日本円
      )
     # if @product.saveの応用で、@product.update。buyer_idをいれて、soldoutにさせる。
      if @product.update(buyer_id: current_user.id)
        flash[:notice] = '購入しました。'
        redirect_to controller: 'products', action: 'show', id: @product.id
      else
        flash[:alert] = '購入に失敗しました。'
        redirect_to controller: 'products', action: 'show', id: @product.id
      end
    end
  end

  private
  def set_card
    @card = Creditcard.where(user_id: current_user.id).first if Creditcard.where(user_id: current_user.id).present?
  end
end
