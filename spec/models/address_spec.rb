require 'rails_helper'

describe Address do
  describe '#create' do
    # 1. アドレスモデルのお届け先・発送先住所の氏名、氏名カナ、郵便番号、住所があれば登録ができること
    it "is valid with a address_firstname, address_lastname, address_firstname_kana, address_lastname_kana, postalcode, prefecture_id, city_name, address_number" do
      address = build(:address)
      expect(address).to be_valid
    end
    # 2. 発送先氏は空では登録できないこと
    it "is invalid without a address_firstname" do
      address = build(:address, address_firstname: nil)
      address.valid?
      expect(address.errors[:address_firstname]).to include("を入力してください")
    end
    # 3. 発送先名は空では登録できないこと
    it "is invalid without a address_firstname" do
      address = build(:address, address_lastname: nil)
      address.valid?
      expect(address.errors[:address_lastname]).to include("を入力してください")
    end
    # 4. 発送先氏カナは空では登録できないこと
    it "is invalid without a address_firstname" do
      address = build(:address, address_firstname_kana: nil)
      address.valid?
      expect(address.errors[:address_firstname_kana]).to include("を入力してください")
    end
    # 5. 発送先名カナは空では登録できないこと
    it "is invalid without a address_lastname_kana" do
      address = build(:address, address_lastname_kana: nil)
      address.valid?
      expect(address.errors[:address_lastname_kana]).to include("を入力してください")
    end
    # 6. 郵便番号は空では登録できないこと
    it "is invalid without a postalcode" do
      address = build(:address, postalcode: nil)
      address.valid?
      expect(address.errors[:postalcode]).to include("を入力してください")
    end
    # 7. 県は空では登録できないこと
    it "is invalid without a prefecture_id" do
      address = build(:address, prefecture_id: nil)
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end
    # 8. 市は空では登録できないこと
    it "is invalid without a city_name" do
      address = build(:address, city_name: nil)
      address.valid?
      expect(address.errors[:city_name]).to include("を入力してください")
    end
    # 9. 番地は空では登録できないこと
    it "is invalid without a address_number" do
      address = build(:address, address_number: nil)
      address.valid?
      expect(address.errors[:address_number]).to include("を入力してください")
    end
    # 10. 郵便番号は空では登録できないこと
    it "is invalid without a postalcode" do
      address = build(:address, postalcode: nil)
      address.valid?
      expect(address.errors[:postalcode]).to include("を入力してください")
    end
    # 11. 建物名が101文字以上であれば登録できないこと
    it "is invalid without a building_name that has more than 101 characters " do
      address = build(:address, building_name: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      address.valid?
      expect(address.errors[:building_name][0]).to include("は100文字以内で入力してください")
    end
    # 12. 建物名が100文字以下であれば登録できること
    it "is valid with a building_name that has less than 100 characters " do
      address = build(:address, building_name: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      address.valid?
      expect(address).to be_valid
    end
    # 13. 電話が101文字以上であれば登録できないこと
    it "is invalid without a address_phone_number that has more than 101 characters " do
      address = build(:address, address_phone_number: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      address.valid?
      expect(address.errors[:address_phone_number][0]).to include("は100文字以内で入力してください")
    end
    # 14. 電話が100文字以下であれば登録できること
    it "is valid with a address_phone_number that has less than 100 characters " do
      address = build(:address, address_phone_number: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      address.valid?
      expect(address).to be_valid
    end
  end
end