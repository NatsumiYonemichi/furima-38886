class PurchasesController < ApplicationController
  before_action :set_item, only: :index

  def index
    @payment_purchase = PaymentPurchase.new
  end

  def create
    @payment_purchase = PaymentPurchase.new(payment_purchase_params)
    if @payment_purchase.valid?
      @payment_purchase.save
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def payment_purchase_params
    params.require(:payment_purchase).permit(:post_code, :prefecture_id, :city, :address, :building, :phone_number).merge(user_id: current_user.id,item_id: params[:item_id])
  end
end