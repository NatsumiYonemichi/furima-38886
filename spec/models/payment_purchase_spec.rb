require 'rails_helper'

RSpec.describe PaymentPurchase, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @payment_purchase = FactoryBot.build(:payment_purchase, user_id: @user.id, item_id: @item.id)
    sleep 0.1
  end

  describe '商品の購入' do
    context '商品が購入できる場合' do
      it '各情報を入力すると購入できる' do
        expect(@payment_purchase).to be_valid
      end

      it 'buildingが空でも購入できる' do
        @payment_purchase.building = ''
        expect(@payment_purchase).to be_valid
      end
    end

    context '商品が購入できない場合' do
      it 'post_codeが空では購入できない' do
        @payment_purchase.post_code = ''
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Post code can't be blank")
      end

      it 'post_codeが3桁ハイフン4桁の半角文字列でないと購入できない' do
        @payment_purchase.post_code = '1234567'
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
      end

      it 'prefectureが未選択では購入できない' do
        @payment_purchase.prefecture_id = 0
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Prefecture can't be blank")
      end

      it 'cityが空では購入できない' do
        @payment_purchase.city = ''
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("City can't be blank")
      end

      it 'addressが空では購入できない' do
        @payment_purchase.address = ''
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空では購入できない' do
        @payment_purchase.phone_number = ''
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberが10桁以下だと購入できない' do
        @payment_purchase.phone_number = '1234567'
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Phone number is invalid.")
      end

      it 'phone_numberが11桁以上だと購入できない' do
        @payment_purchase.phone_number = '123456789012'
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Phone number is invalid.")
      end

      it 'phone_numberに-が入っていると購入できない' do
        @payment_purchase.phone_number = '090-1234-5678'
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Phone number is invalid.")
      end

      it 'ユーザーが紐づいていなければ購入できない' do
        @payment_purchase.user_id = ''
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("User can't be blank")
      end

      it '商品が紐づいていなければ購入できない' do
        @payment_purchase.item_id = ''
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Item can't be blank")
      end

      it "tokenが空では登録できないこと" do
        @payment_purchase.token = nil
        @payment_purchase.valid?
        expect(@payment_purchase.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
