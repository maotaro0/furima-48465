require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '商品出品' do
    before do
      @item = build(:item)
    end

    context '正常系' do
      it '商品情報が正常なら商品を登録できる' do
        expect(@item).to be_valid
      end
    end

    context '異常系' do
      it 'ユーザーがいない場合は商品を登録できない' do
        @item.user = nil
        expect(@item).not_to be_valid
      end

      it '画像がない場合は商品を登録できない' do
        @item.image = nil
        expect(@item).not_to be_valid
      end

      it '商品名がない場合は商品を登録できない' do
        @item.name = nil
        expect(@item).not_to be_valid
      end

      it '商品説明がない場合は商品を登録できない' do
        @item.description = nil
        expect(@item).not_to be_valid
      end

      it 'カテゴリーが「---」の場合は商品を登録できない' do
        @item.category_id = 1
        expect(@item).not_to be_valid
      end

      it '商品の状態が「---」の場合は商品を登録できない' do
        @item.condition_id = 1
        expect(@item).not_to be_valid
      end

      it '配送料の負担が「---」の場合は商品を登録できない' do
        @item.shipping_fee_id = 1
        expect(@item).not_to be_valid
      end

      it '発送元の地域が「---」の場合は商品を登録できない' do
        @item.shipping_origin_id = 1
        expect(@item).not_to be_valid
      end

      it '発送までの日数が「---」の場合は商品を登録できない' do
        @item.shipping_day_id = 1
        expect(@item).not_to be_valid
      end

      it '価格がない場合は商品を登録できない' do
        @item.price = nil
        expect(@item).not_to be_valid
      end

      it '価格が300円未満の場合は商品を登録できない' do
        @item.price = 299
        expect(@item).not_to be_valid
      end

      it '価格が9,999,999円を超える場合は商品を登録できない' do
        @item.price = 10_000_000
        expect(@item).not_to be_valid
      end

      it '価格が半角数値ではない場合は商品を登録できない' do
        @item.price = '３００'
        expect(@item).not_to be_valid
      end

      it '価格が整数ではない場合は商品を登録できない' do
        @item.price = 300.5
        expect(@item).not_to be_valid
      end
    end
  end
end
