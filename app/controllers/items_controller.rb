class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @items = Item.includes(:user)
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :category, :status, :postage, :prefecture, :shipping_day, :price).merge(user_id: current_user.id)
  end

  # def set_tweet # editとshowの @tweet = Tweet.find(params[:id])を集約
  #   @tweet = Tweet.find(params[:id])
  # end

end
