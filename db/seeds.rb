# frozen_string_literal: true

require 'faker'

1.upto(10) do |i|
  Item.create!(
    original_price: rand(100.200)
  )
  p "ITEM #{i} : créé"
end
