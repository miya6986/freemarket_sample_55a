class CreditcardsController < ApplicationController
  require "payjp"
  before_action :set_card

  def index
    if @card.present?
      # Payjpの秘密鍵をセットして、Payjpの処理ができるようにする。
      Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
      # Payjp::Customer.retrieve(Payjp上のid)でPayjpの顧客情報を引き出す。
      customer = Payjp::Customer.retrieve(@card.customer_id)
      # customer.cards.retrieve(Payjp上のクレジットカードid)でPayjpのカード情報を引き出す。
      # はじめに登録したカードがデフォルトカードとして登録されるので、customer.default_cardでカードidを読み取っている。
      @card_info = customer.cards.retrieve(customer.default_card)
      #上記でカードを読み込んだので、カード情報よりbrand情報や、有効期限 などを取得する。
      @card_brand = @card_info.brand
      @exp_month = @card_info.exp_month.to_s
      @exp_year = @card_info.exp_year.to_s.slice(2,3) 
      case @card_brand
        # 取得した@card_brandによって、VISA、JCBなどの画像に切り替えて表示させる。
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
    # 新規登録する際はカード情報がないので、before_action :set_cardでは@cardが定義されない。
    #　そのため、@cardをセットする。
    @card = Creditcard.where(user_id: current_user.id).first
    redirect_to action: "index" if @card.present?    
  end

  def create
    # カード情報はPayjpで保存するので、Payjpの処理をさせるため、秘密鍵をセット。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # Payjp.jsで作成したトークンがないときは処理しない。
    if params['payjpToken'].blank?
      render "new"
    else
      # Payjp.jsで作成したトークンがある場合、処理をする。
      # Payjp上でcustomerを生成する。card: params['payjpToken']でカード情報を登録する。
      customer = Payjp::Customer.create(
        description: 'test',
        email: current_user.email,
        card: params['payjpToken'],
        metadata: {user_id: current_user.id}
      )
      # 下記はこのAppのdb上に保存するクレジットカード情報。user_idとPayjpのcustomer.idを保存しておく。
      @card = Creditcard.new(user_id: current_user.id, customer_id: customer.id)
        if @card.save
          redirect_to action: "index", notice:"支払い情報の登録が完了しました"
        else
          render 'new'
        end
    end
  end

  def destroy     
    # Payjpの処理をさせるため、秘密鍵をセット。
    Payjp.api_key = ENV["PAYJP_PRIVATE_KEY"]
    # Payjpのcustomerを引き出す。
    customer = Payjp::Customer.retrieve(@card.customer_id)
    # 引き出した顧客情報を削除する。それにより、カード情報ごと削除する。
    customer.delete
    if @card.destroy
      # 無事にPayjp上からカード情報を削除できたら、dbのクレジットカード情報も削除する。
      redirect_to action: "index", notice: "削除しました"
    else
      redirect_to action: "index", alert: "削除できませんでした"
    end
  end

  private
  def set_card
    @card = Creditcard.where(user_id: current_user.id).first if Creditcard.where(user_id: current_user.id).present?
  end
end
