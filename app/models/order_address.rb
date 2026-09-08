class OrderAddress
  include ActiveModel::Model

  attr_accessor :postal_code, :prefecture_id, :city, :house_number, :building,
   :phone_number, :user_id, :item_id, :user, :item,  :token

  with_options presence: true do  
    validates :postal_code
    validates :city
    validates :house_number
    validates :phone_number
    validates :token
    validates :user_id
    validates :item_id
  end

   validates :postal_code, format: { with: /\A\d{3}-\d{4}\z/ }
   validates :prefecture_id, numericality: { other_than: 1, message: "can't be blank" }
   validates :phone_number, format: { with: /\A\d{10,11}\z/ }


  def save
    return false unless valid?

    order = Order.create(user_id: user_id, item_id: item_id)

    Address.create(
      postal_code: postal_code,
      prefecture_id: prefecture_id,
      city: city,
      house_number: house_number,
      building: building,
      phone_number: phone_number,
      order_id: order.id
    )
  end
end
