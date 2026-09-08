require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報' do
    before do
      user = create(:user)
      item = create(:item)
      @order_address = build(:order_address, user_id: user.id, item_id: item.id)
    end

    context '正常系' do
      it '購入情報が正常なら購入できる' do
        expect(@order_address).to be_valid
      end

      it '建物名がなくても購入情報を登録できる' do
        @order_address.building = nil
        expect(@order_address).to be_valid
      end
    end

    context '異常系' do
      it '郵便番号がない場合は購入情報を登録できない' do
        @order_address.postal_code = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Postal code can't be blank")
      end

      it '郵便番号が3桁-4桁ではない場合は購入情報を登録できない' do
        @order_address.postal_code = '1234567'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Postal code is invalid")
      end

      it '都道府県が「---」の場合は購入情報を登録できない' do
        @order_address.prefecture_id = 1
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Prefecture can't be blank")
      end

      it '市区町村がない場合は購入情報を登録できない' do
        @order_address.city = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("City can't be blank")
      end

      it '番地がない場合は購入情報を登録できない' do
        @order_address.house_number = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("House number can't be blank")
      end

      it '電話番号がない場合は購入情報を登録できない' do
        @order_address.phone_number = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Phone number can't be blank")
      end

      it '電話番号が10桁未満の場合は購入情報を登録できない' do
        @order_address.phone_number = '123456789'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号が11桁を超える場合は購入情報を登録できない' do
        @order_address.phone_number = '000123456789'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it '電話番号にハイフンが含まれる場合は購入情報を登録できない' do
        @order_address.phone_number = '000-1234-5678'
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Phone number is invalid")
      end

      it 'トークンがない場合は購入情報を登録できない' do
        @order_address.token = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Token can't be blank")
      end

      it 'userが紐付いていない場合は購入情報を登録できない' do
        @order_address.user_id = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("User can't be blank")
      end

      it 'itemが紐付いていない場合は購入情報を登録できない' do
        @order_address.item_id = nil
        expect(@order_address).not_to be_valid
        expect(@order_address.errors.full_messages).to include("Item can't be blank")
      end

    end
  end
end
