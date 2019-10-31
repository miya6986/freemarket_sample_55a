require 'rails_helper'

RSpec.describe Product do 
  describe "#create" do
    let(:parent) { build(:category)}
    let(:child) { build(:category)}
    let(:grandchild){ build(:category)}
    let(:product){ build(:product, categories: [parent, child, grandchild])}  

    context "can save" do
      #1 name,description,condition,category(親・子・孫の３つ),postage(配送料の負担),
      # shipping_method,prefecture_id,shipping_days,priceが存在していれば出品ができること
      it "is valid with required items" do
        expect(product).to be_valid
      end
    end

    context "cannot save" do 
      #1 商品名が空であれば保存できないこと
      it "is invalid without product-name" do
        product = build(:product, name: nil)
        product.valid?
        expect(product.errors[:name]).to include("can't be blank")
      end

      #2 商品の説明が空であれば保存できないこと
      it "is invalid without product-description" do
        product = build(:product, description: nil)
        product.valid?
        expect(product.errors[:description]).to include("can't be blank")
      end

      #3 カテゴリが空であれば保存できないこと
      it "is invalid without categories" do
        product = build(:product, category_ids: nil)
        product.valid?
        expect(product.errors[:category_ids]).to include("選択してください")
      end

      #4 子カテゴリが空であれば保存できないこと
      it "is invalid without child-category although with parent" do
        product = build(:product, categories: [parent])
        product.valid?
        expect(product.errors[:category_ids]).to include("選択してください")
      end

      #5 孫カテゴリが空であれば保存できないこと
      it "is invalid without grandchild-category although with parent & child" do
        product = build(:product, categories: [parent, child])
        product.valid?
        expect(product.errors[:category_ids]).to include("選択してください")
      end

      #6 商品の状態が空であれば保存できないこと
      it "is invalid without product-condition" do
        product = build(:product,condition: nil)
        product.valid?
        expect(product.errors[:condition]).to include("can't be blank")
      end

      #7 配送料の負担が空であれば保存できないこと
      it "is invalid without postage" do
        product = build(:product, postage: nil)
        product.valid?
        expect(product.errors[:postage]).to include("can't be blank")
      end

      #8 発送元の地域が空であれば保存できないこと
      it "is invalid without shipping_area" do
        product = build(:product,  prefecture_id: nil)
        product.valid?
        expect(product.errors[:prefecture_id]).to include("can't be blank")
      end

      #9 配送までの日数が空であれば保存できないこと
      it "is invalid without shipping-days" do
        product = build(:product, shipping_days: nil)
        product.valid?
        expect(product.errors[:shipping_days]).to include("can't be blank")
      end

      #10 価格が空であれば保存できないこと
      it "is invalid without price" do
        product = build(:product, price: nil)
        product.valid?
        expect(product.errors[:price]).to include("can't be blank")
      end
    end
  end

end