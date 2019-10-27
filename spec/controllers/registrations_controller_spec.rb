require 'rails_helper'


describe RegistrationsController, type: :controller do

# step1のページに移管できること
  describe 'Get#step1' do
    it "renders the :step1 templete" do
      get :step1
      expect(response).to render_template :step1
    end
  end

# step2,step3,step4のページに移管できること
  describe 'Get#step2' do
    it "renders the :step2 templete" do
      get :step2
      expect(response).to render_template :step2
    end

    it "renders the :step3 templete" do
      get :step3, params: { user: {nickname: :user, email: :user, password: :user, password_confirmation: :user, firstname: :user, lastname: :user, firstname_kana: :user, lastname_kana: :user, birth_year: :user, birth_month: :user, birth_day: :user}}
      expect(response).to render_template :step3
    end

    it "renders the :step4 templete" do
      get :step4, params: { user: {phone_number: :user}}, session: { user: {nickname: :user, email: :user, password: :user, password_confirmation: :user, firstname: :user, lastname: :user, firstname_kana: :user, lastname_kana: :user, birth_year: :user, birth_month: :user, birth_day: :user}}
      expect(response).to render_template :step4
    end
  end
  
  # step5のページに移管できること
    describe 'Get#step5' do
      it "renders the :step5 templete" do
        get :step5
        expect(response).to render_template :step5
      end
    end


  # 以下相談事項

  # dbにAddress新規登録情報が登録できること
  describe '#create' do
    it "saves the new contact in the database" do
      address_params = FactoryBot.attributes_for(:address)
      expect { post :create, params: { user: { address_attributes: { address: address_params }}}}.to change(Address, :count).by(1)
    end
  end
end
