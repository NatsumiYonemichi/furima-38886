class PurchasesController < ApplicationController
  def index
    @payment_purchase = PaymentPurchase.new
  end
end