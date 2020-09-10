class OrdersController < ApplicationController
  before_action :authenticate_user!
  before_action :correct_user, only: [:index]

  def index
  end

  def create
  end

private

  def correct_user
    @item = Item.find(params[:item_id])
    redirect_to root_path if @item.user == current_user
  end
end
