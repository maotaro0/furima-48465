require 'rails_helper'

RSpec.describe OrderAddress, type: :model do
  describe '購入情報' do
    before do
      @order_address = build(:order_address)
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
      end

      it '郵便番号が3桁-4桁ではない場合は購入情報を登録できない' do
        @order_address.postal_code = '1234567'
        expect(@order_address).not_to be_valid
      end

      it '都道府県が「---」の場合は購入情報を登録できない' do
        @order_address.prefecture_id = 1
        expect(@order_address).not_to be_valid
      end

      it '市区町村がない場合は購入情報を登録できない' do
        @order_address.city = nil
        expect(@order_address).not_to be_valid
      end

      it '番地がない場合は購入情報を登録できない' do
        @order_address.addresses = nil
        expect(@order_address).not_to be_valid
      end

      it '電話番号がない場合は購入情報を登録できない' do
        @order_address.phone_number = nil
        expect(@order_address).not_to be_valid
      end

      it '電話番号が10桁未満の場合は購入情報を登録できない' do
        @order_address.phone_number = '123456789'
        expect(@order_address).not_to be_valid
      end

      it '電話番号が11桁を超える場合は購入情報を登録できない' do
        @order_address.phone_number = '000123456789'
        expect(@order_address).not_to be_valid
      end

      it '電話番号にハイフンが含まれる場合は購入情報を登録できない' do
        @order_address.phone_number = '000-1234-5678'
        expect(@order_address).not_to be_valid
      end

      it 'トークンがない場合は購入情報を登録できない' do
        @order_address.token = nil
        expect(@order_address).not_to be_valid
      end
    end
  end
end
