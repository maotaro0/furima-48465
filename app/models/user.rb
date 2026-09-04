class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items

  VALID_NAME_REGEX = /\A[ぁ-んァ-ヶ一-龥々ー]+\z/
  VALID_KANA_REGEX = /\A[ァ-ヶー]+\z/
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-zA-Z])(?=.*?\d)[a-zA-Z\d]+\z/

  validates :nickname, :last_name, :first_name,
            :last_name_kana, :first_name_kana, :birth_date,
            presence: true

  validates :last_name, :first_name,
            format: { with: VALID_NAME_REGEX }

  validates :last_name_kana, :first_name_kana,
            format: { with: VALID_KANA_REGEX }

  validates :password,
            format: { with: VALID_PASSWORD_REGEX }
end
