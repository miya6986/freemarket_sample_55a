require 'rails_helper'

describe User do
  describe '#create' do
    # 1. ユーザーモデルのニックネーム、メールアドレス、氏名、氏名カナ、生年月日、電話番号があれば登録ができること
    it "is valid with a nickname, email, firstname, lastname, firstname_kana, lastname_kana, birth_year, birth_month, birth_day, phone_number" do
      user = build(:user)
      expect(user).to be_valid
    end
    # 2. ニックネームは空では登録できないこと
    it "is invalid without a nickname" do
      user = build(:user, nickname: nil)
      user.valid?
      expect(user.errors[:nickname]).to include("を入力してください")
    end
    # 3. メールアドレスは空では登録できないこと
    it "is invalid without a email" do
      user = build(:user, email: nil)
      user.valid?
      expect(user.errors[:email]).to include("を入力してください")
    end
    # 4. 姓は空では登録できないこと
    it "is invalid without a firstname" do
      user = build(:user, firstname: nil)
      user.valid?
      expect(user.errors[:firstname]).to include("を入力してください")
    end
    # 5. 名は空では登録できないこと
    it "is invalid without a lastname" do
      user = build(:user, lastname: nil)
      user.valid?
      expect(user.errors[:lastname]).to include("を入力してください")
    end
    # 6. 姓カナは空では登録できないこと
    it "is invalid without a firstname_kana" do
      user = build(:user, firstname_kana: nil)
      user.valid?
      expect(user.errors[:firstname_kana]).to include("を入力してください")
    end
    # 7. 名カナは空では登録できないこと
    it "is invalid without a lastname_kana" do
      user = build(:user, lastname_kana: nil)
      user.valid?
      expect(user.errors[:lastname_kana]).to include("を入力してください")
    end
    # 8. 誕生年は空では登録できないこと
    it "is invalid without a birth_year" do
      user = build(:user, birth_year: nil)
      user.valid?
      expect(user.errors[:birth_year]).to include("を入力してください")
    end
    # 9. 誕生月は空では登録できないこと
    it "is invalid without a birth_month" do
      user = build(:user, birth_month: nil)
      user.valid?
      expect(user.errors[:birth_month]).to include("を入力してください")
    end
    # 10. 誕生日は空では登録できないこと
    it "is invalid without a birth_day" do
      user = build(:user, birth_day: nil)
      user.valid?
      expect(user.errors[:birth_day]).to include("を入力してください")
    end
    # 11. 電話番号は空では登録できないこと
    it "is invalid without a phone_number" do
      user = build(:user, phone_number: nil)
      user.valid?
      expect(user.errors[:phone_number]).to include("を入力してください")
    end
    # 12. ニックネームが20文字以下であれば登録できること
    it "is valid with a nickname that has less than 19 characters " do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end
    # 13. ニックネームが21文字以上であれば登録できないこと
    it "is invalid without a nickname that has more than 21 characters " do
      user = build(:user, nickname: "aaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:nickname][0]).to include("は20文字以内で入力してください")
    end
    # 14. 姓が35文字以下であれば登録できること
    it "is valid with a firstname that has less than 35 characters " do
      user = build(:user, firstname: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end
    # 15. 姓が36文字以上であれば登録できないこと
    it "is invalid without a firstname that has more than 36 characters " do
      user = build(:user, firstname: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:firstname][0]).to include("は35文字以内で入力してください")
    end
    # 16. 名が35文字以下であれば登録できること
    it "is valid with a lastname that has less than 35 characters " do
      user = build(:user, lastname: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end
    # 17. 名が36文字以上であれば登録できないこと
    it "is invalid without a lastname that has more than 36 characters " do
      user = build(:user, lastname: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:lastname][0]).to include("は35文字以内で入力してください")
    end
    # 18. 姓カナが35文字以下であれば登録できること
    it "is valid with a firstname_kana that has less than 35 characters " do
      user = build(:user, firstname_kana: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end
    # 19. 姓カナが36文字以上であれば登録できないこと
    it "is invalid without a firstname_kana that has more than 36 characters " do
      user = build(:user, firstname_kana: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:firstname_kana][0]).to include("は35文字以内で入力してください")
    end
    # 20. 名カナが35文字以下であれば登録できること
    it "is valid with a lastname_kana that has less than 35 characters " do
      user = build(:user, lastname_kana: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user).to be_valid
    end
    # 21. 名カナが36文字以上であれば登録できないこと
    it "is invalid without a lastname_kana that has more than 36 characters " do
      user = build(:user, lastname_kana: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa")
      user.valid?
      expect(user.errors[:lastname_kana][0]).to include("は35文字以内で入力してください")
    end
    # 22. 電話番号が11文字以下であれば登録できること
    it "is valid with a phone_number that has less than 11 characters " do
      user = build(:user, phone_number: "11111111111")
      user.valid?
      expect(user).to be_valid
    end
    # 23. 電話番号が12文字以上であれば登録できないこと
    it "is invalid without a phone_number that has more than 12 characters " do
      user = build(:user, phone_number: "111111111111")
      user.valid?
      expect(user.errors[:phone_number][0]).to include("は不正な値です")
    end
    # 24. 重複したメールアドレスが存在する場合登録できないこと
    it "is invalid with a duplicate email address" do
      user = create(:user)
      another_user = build(:user, email: user.email)
      another_user.valid?
      expect(another_user.errors[:email]).to include("はすでに存在します")
    end
    # 25. 重複した電話番号が存在する場合登録できないこと
    it "is invalid with a duplicate phone_number address" do
      user = create(:user)
      another_user = build(:user, phone_number: user.phone_number)
      another_user.valid?
      expect(another_user.errors[:phone_number]).to include("はすでに存在します")
    end
  end
end
