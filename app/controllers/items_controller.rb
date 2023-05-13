class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end

  private

  def item_params
    params.require(:item).permit(:name, :introduction, :price, :category_id, :condition_id, :prefecture_id, :postage_type_id, :shipping_day_id, :image).merge(user_id: current_user.id)
  end
end