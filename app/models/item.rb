class Item < ApplicationRecord
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions

  belongs_to :user
  belongs_to :category
  belongs_to :condition
  belongs_to :shipping_fee
  belongs_to :shipping_origin
  belongs_to :shipping_day

  validates :image, :name, :description, presence: true
  validates :category_id, :condition_id, :shipping_fee_id, :shipping_origin_id,
            :shipping_day_id, numericality: { other_than: 1, message: "can't be blank" }

  validates :price, numericality: {
    only_integer: true,
    greater_than_or_equal_to: 300,
    less_than_or_equal_to: 9_999_999
  }
end
