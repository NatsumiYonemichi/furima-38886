class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :edit, :destroy]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :move_to_index, only: :edit

  def index
    @items = Item.all.order('created_at DESC')
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
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if current_user == item.user
      item.destroy
    end
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :category_id, :condition_id, :postage_type_id, :prefecture_id,
                                 :shipping_day_id, :image).merge(user_id: current_user.id)
  end

  def set_item
    @item = Item.find(params[:id])
  end

  def move_to_index
    if current_user == @item.user
      if @item.purchase.present?
        redirect_to action: :index
      end
    else
      redirect_to action: :index
    end
  end

end