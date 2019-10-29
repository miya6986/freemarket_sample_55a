require 'rails_helper'

Rspec.describe Product do 
  describe "#create" do
    it "is invalid without product-name" do
      product = Product.new(name: "")
      product.valid?
      expect(product.errors[:name]).to include("can't be blank")
    end
  end

end