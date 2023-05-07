require 'rails_helper'

RSpec.describe User, type: :model do
  
  before do
    @user = User.new
    @user.nickname = "yama"
    @user.email = Faker::Internet.free_email
    @user.password = ('1a'+ Faker::Internet.password(min_length:6))
    @user.password_confirmation = @user.password
    @user.family_name = "山田"
    @user.first_name = "花子"
    @user.family_name_kana = "ヤマダ"
    @user.first_name_kana = "ハナコ"
    @user.birthday = Faker::Date.birthday
  end

  describe 'ユーザー新規登録' do
    context '新規登録できる場合' do
      it "nickname,email,password,password_confirmation,family_name,first_name,family_name_kana,first_name_kana,birthdayが存在すれば登録できる" do
        expect(@user).to be_valid
      end
    end

    context '新規登録できない場合' do
      it "nicknameが空では登録できない" do
        @user.nickname = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("Nickname can't be blank")
      end

      it "emailが空では登録できない" do
        @user.email = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("Email can't be blank")
      end

      it "passwordが空では登録できない" do
        @user.password = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password can't be blank")
      end

      it 'passwordが5文字以下では登録できない' do
        @user.password = "qwer5"
        @user.password_confirmation = "qwer5"
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password is too short (minimum is 6 characters)")
      end

      it 'passwordが129文字以上では登録できない' do
        @user.password = Faker::Internet.password(min_length: 129)
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include("Password is too long (maximum is 128 characters)")
      end

      it 'passwordとpassword_confirmationが不一致では登録できない' do
        @user.password = "123456"
        @user.password_confirmation = '654321'
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password confirmation doesn't match Password")
      end

      it 'passwordが英数字混合でないと登録できない' do
        @user.password = "123456"
        @user.password_confirmation = @user.password
        @user.valid?
        expect(@user.errors.full_messages).to include ("Password には英字と数字の両方を含めて設定してください")
      end

      it '重複したemailが存在する場合は登録できない' do
        @user.save
        another_user = User.new
        another_user.nickname = "yama"
        another_user.password = ('1a'+ Faker::Internet.password(min_length:6))
        another_user.password_confirmation = @user.password
        another_user.family_name = "山田"
        another_user.first_name = "花子"
        another_user.family_name_kana = "ヤマダ"
        another_user.first_name_kana = "ハナコ"
        another_user.birthday = Faker::Date.birthday
        another_user.email = @user.email
        another_user.valid?
        expect(another_user.errors.full_messages).to include ("Email has already been taken")
      end

      it 'emailは@を含まないと登録できない' do
        @user.email = "qwertyu"
        @user.valid?
        expect(@user.errors.full_messages).to include ("Email is invalid")
      end

      it "family_nameが空では登録できない" do
        @user.family_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name can't be blank")
      end

      it "family_nameが全角以外では登録できない" do
        @user.family_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name is invalid. Input full-width characters.")
      end

      it "first_nameが空では登録できない" do
        @user.first_name = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name can't be blank")
      end

      it "first_nameが全角以外では登録できない" do
        @user.first_name = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name is invalid. Input full-width characters.")
      end

      it "family_name_kanaが空では登録できない" do
        @user.family_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name kana can't be blank")
      end

      it "family_name_kanaが全角カタカナ以外では登録できない" do
        @user.family_name_kana = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include ("Family name kana is invalid. Input full-width katakana characters.")
      end

      it "first_name_kanaが空では登録できない" do
        @user.first_name_kana = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name kana can't be blank")
      end

      it "first_name_kanaが全角カタカナ以外では登録できない" do
        @user.first_name_kana = "aaa"
        @user.valid?
        expect(@user.errors.full_messages).to include ("First name kana is invalid. Input full-width katakana characters.")
      end

      it "birthdayが空では登録できない" do
        @user.birthday = ""
        @user.valid?
        expect(@user.errors.full_messages).to include ("Birthday can't be blank")
      end
    end
  end
end
