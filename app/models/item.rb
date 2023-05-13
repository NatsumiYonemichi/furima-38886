class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :condition
  belongs_to :prefecture
  belongs_to :postage_type
  belongs_to :shipping_day

  belongs_to :user
  has_one_attached :image

  with_options presence: true do
    validates :name
    validates :introduction
    validates :price
  end

  with_options numericality: { other_than: 0, message: "can't be blank" } do
    validates :category_id
    validates :condition_id
    validates :prefecture_id
    validates :postage_type_id
    validates :shipping_day_id
  end

  validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: "is invalid"}

end