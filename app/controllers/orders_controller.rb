class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :excluding_seller, only: [:index]
  before_action :excluding_purchased, only: [:index]

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

  def excluding_seller
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.user == current_user
  end

  def excluding_purchased
    @item = Item.find(params[:item_id])
    # Ordersテーブルのitem_idカラムを参照し、Itemsテーブルのidが一致するレコードを取得
    @order = Order.find_by(item_id: @item.id)
    redirect_to root_path if @order
  end
end
