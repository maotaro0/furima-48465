class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item
  before_action :check_purchase

  def index
    gon.public_key = ENV['PAYJP_PUBLIC_KEY']
    @order_address = OrderAddress.new
  end

  def create
    @order_address = OrderAddress.new(order_params)
    @order_address.item_id = @item.id
    @order_address.user_id = current_user.id

    if @order_address.valid?
      pay_item
      @order_address.save
      redirect_to root_path
    else
      gon.public_key = ENV['PAYJP_PUBLIC_KEY']
      render :index, status: :unprocessable_entity
    end
  end

  def pay_item
    Payjp.api_key = ENV['PAYJP_SECRET_KEY']
    Payjp::Charge.create(
      amount: @item.price,
      card: @order_address.token,
      currency: 'jpy'
    )
  end

  private

  def check_purchase
    redirect_to root_path if @item.user == current_user || @item.order.present?
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def order_params
    params.require(:order_address).permit(
      :postal_code,
      :prefecture_id,
      :city,
      :house_number,
      :building,
      :phone_number
    )
          .merge(token: params[:token])
  end
end
