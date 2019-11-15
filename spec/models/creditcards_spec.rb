require 'rails_helper'
describe Creditcard do
  let(:user) { create(:user) }
  
  describe '#create' do
    it "is valid with a user_id, customer_id" do
      creditcard = build(:creditcard) 
      expect(creditcard).to be_valid
    end
  end
end

