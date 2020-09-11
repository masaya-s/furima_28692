class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:index]

  def index
    @order = ItemOrder.new
  end

  def create
    @item = Item.find(params[:item_id])
    @order = ItemOrder.new(order_params)
    if @order.valid?
      pay_item
      @order.save
      return redirect_to root_path
    else
      render :index
    end
  end

  private

  def order_params
    params.permit(:token, :item_id, :postal_code, :prefecture, :city, :address, :building, :phone_number).merge(user_id: current_user.id)
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency:'jpy'
    )
  end

  def correct_user
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.user == current_user
  end
end
