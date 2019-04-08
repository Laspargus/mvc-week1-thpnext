# frozen_string_literal: true

# == Schema Information
#
# Table name: items
#
#  id                  :bigint(8)        not null, primary key
#  original_price      :float            not null
#  has_discount        :boolean          default(FALSE)
#  discount_percentage :integer          default(0)
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class Item < ApplicationRecord
  validates :discount_percentage, inclusion: { in: 0..100 }
  validates :discount_percentage, numericality: true

  validates :original_price, :has_discount, presence: { message: "Original price must be present" }
  validates_numericality_of :original_price, :greater_than => 0.0

  def price
    has_discount ? original_price - (original_price * discount_percentage / 100) : original_price
  end

  def self.average_price
    items = Item.all
    stock_value = 0
    items.each do |item|
      stock_value += item.price
    end
    (stock_value / items.count).to_f if items.count > 0
  end
end
