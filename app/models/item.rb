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

  validates :original_price, presence: { message: "Original price must be present" }
  validates :original_price, numericality: { greater_than: 0.0 }

  def price
    has_discount ? (original_price - (original_price * discount_percentage / 100)).round(2) : original_price
  end

  def self.average_price
    items = Item.all
    stock_value = 0
    items.each do |item|
      stock_value += item.price
    end
    (stock_value / items.count) if items.count.positive?
  end

  def self.average_price_refacto
    (where(has_discount: true).sum('original_price - (original_price * discount_percentage/100)') + where(has_discount: false).sum(:original_price)) / count
  end
end
