require 'rails_helper'

describe Creditcard do
  let(:user) { create(:user) }
  describe '#create' do
    context 'can save' do
      it "is valid with a user_id, customer_id" do
        creditcard = build(:creditcard)
        expect(creditcard).to be_valid
      end

      it "is valid with a user_id" do
        creditcard = build(:creditcard, customer_id: nil)
        creditcard.valid?
        expect(creditcard.errors[:customer_id]).to include("を入力してください")
      end

      
    end
  end
end

