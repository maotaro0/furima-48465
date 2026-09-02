require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'ユーザー新規登録' do
    it '必要な情報がすべて入力されていれば登録できる' do
      user = build(:user)
      expect(user).to be_valid
    end

    it 'nicknameが空では登録できない' do
      user = build(:user)
      user.nickname = ''
      user.valid?
      expect(user.errors.full_messages).to include("Nickname can't be blank")
    end

    it 'emailが空では登録できない' do
      user = build(:user)
      user.email = ''
      user.valid?

      expect(user.errors.full_messages).to include("Email can't be blank")
    end

    it 'emailが重複している場合は登録できない' do
      user = FactoryBot.create(:user)
      another_user = FactoryBot.build(:user, email: user.email)

      another_user.valid?

      expect(another_user.errors.full_messages).to include('Email has already been taken')
    end

    it 'emailに@が含まれていない場合は登録できない' do
      user = build(:user)
      user.email = 'testexample.com'
      user.valid?

      expect(user.errors.full_messages).to include('Email is invalid')
    end

    it 'passwordが空では登録できない' do
      user = build(:user, password: '', password_confirmation: '')
      user.valid?

      expect(user.errors.full_messages).to include("Password can't be blank")
    end

    it 'passwordが6文字未満では登録できない' do
      user = build(:user, password: 'abc12', password_confirmation: 'abc12')
      user.valid?

      expect(user.errors.full_messages).to include(
        'Password is too short (minimum is 6 characters)'
      )
    end

    it 'passwordとpassword_confirmationが一致しない場合は登録できない' do
      user = build(
        :user,
        password: 'abc123',
        password_confirmation: 'abc456'
      )
      user.valid?

      expect(user.errors.full_messages).to include(
        "Password confirmation doesn't match Password"
      )
    end

    it 'passwordが半角英数字混合でない場合は登録できない' do
      user = build(:user, password: 'abcdef', password_confirmation: 'abcdef')
      user.valid?

      expect(user.errors.full_messages).to include('Password is invalid')
    end

    it 'last_nameが空では登録できない' do
      user = build(:user, last_name: '')
      user.valid?

      expect(user.errors.full_messages).to include("Last name can't be blank")
    end

    it 'first_nameが空では登録できない' do
      user = build(:user, first_name: '')
      user.valid?

      expect(user.errors.full_messages).to include("First name can't be blank")
    end

    it 'last_nameが全角でない場合は登録できない' do
      user = build(:user, last_name: 'yamada')
      user.valid?

      expect(user.errors.full_messages).to include('Last name is invalid')
    end

    it 'first_nameが全角でない場合は登録できない' do
      user = build(:user, first_name: 'taro')
      user.valid?

      expect(user.errors.full_messages).to include('First name is invalid')
    end

    it 'last_name_kanaが空では登録できない' do
      user = build(:user, last_name_kana: '')
      user.valid?

      expect(user.errors.full_messages).to include("Last name kana can't be blank")
    end

    it 'last_name_kanaが全角カタカナでない場合は登録できない' do
      user = build(:user, last_name_kana: 'やまだ')
      user.valid?

      expect(user.errors.full_messages).to include('Last name kana is invalid')
    end

    it 'first_name_kanaが空では登録できない' do
      user = build(:user, first_name_kana: '')
      user.valid?

      expect(user.errors.full_messages).to include("First name kana can't be blank")
    end

    it 'first_name_kanaが全角カタカナでない場合は登録できない' do
      user = build(:user, first_name_kana: 'たろう')
      user.valid?

      expect(user.errors.full_messages).to include('First name kana is invalid')
    end

    it 'birth_dateが空では登録できない' do
      user = build(:user, birth_date: '')
      user.valid?

      expect(user.errors.full_messages).to include("Birth date can't be blank")
    end
  end
end
