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
	def price
		has_discount ? original_price - (original_price * discount_percentage / 100)  : original_price
	end

	def self.average_price
		items = Item.all
		stock_value = 0
		stock_items = 0
		items.each do |item|
			stock_value += item.price
			stock_items += 1
		end
		stock_value / stock_items.to_f
	end
end
