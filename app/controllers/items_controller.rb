class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:edit, :update]

  def index
    @items = Item.includes(:user).order('id DESC')
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

  def show
    @item = Item.find(params[:id])
  end

  def update
    if  @item.update(item_params)
      redirect_to root_path
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  private

  def item_params
    params.require(:item).permit(:image, :name, :introduction, :category, :status, :postage, :prefecture, :shipping_day, :price).merge(user_id: current_user.id)
  end

  def correct_user
    @item = Item.find(params[:id])
    # 現在のユーザーが自分以外の商品編集・更新ページにアクセスしようとすると、ホーム画面にリダイレクトさせる
    redirect_to root_path unless @item.user==current_user
  end
end