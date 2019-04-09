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

require 'rails_helper'

RSpec.describe Item, type: :model do
  describe 'Model instantiation' do
    subject(:new_item) { described_class.new }

    describe 'Database' do
      it { is_expected.to have_db_column(:id).of_type(:integer) }
      it { is_expected.to have_db_column(:original_price).of_type(:float).with_options(null: false) }
      it { is_expected.to have_db_column(:created_at).of_type(:datetime).with_options(null: false) }
      it { is_expected.to have_db_column(:discount_percentage).of_type(:integer) }
      it { is_expected.to have_db_column(:has_discount).of_type(:boolean) }
      it { is_expected.to have_db_column(:updated_at).of_type(:datetime).with_options(null: false) }
    end
  end

  describe 'Price' do
    context 'when the item has a discount' do
      let(:item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(80.00) }
    end

    context 'when the item has no discount' do
      let(:item) { build(:item_without_discount, original_price: 100.00, discount_percentage: 20) }

      it { expect(item.price).to eq(100.00) }
      it { expect(item.has_discount).to be(false) }
    end
  end

  # describe 'Average Price' do
  # context 'verify average price' do
  #  let(:item1) { create(:item_with_discount, original_price: 100.00, discount_percentage: 10) }
  # let(:item2) { create(:item_without_discount, original_price: 30.00, discount_percentage: 20) }
  # let(:item3) { create(:item_with_discount, original_price: 66.00, discount_percentage: 10) }
  # it { expect(Item.last(3).average_price).to eq(60.00) }
  # end
  # end

  describe "Discount Percentage" do
    context 'when discount_percentage is negativ' do
      it { is_expected.not_to allow_value(-20).for(:discount_percentage) }
    end

    context 'when discount_percentage is superior to 100' do
      let(:fake_item) { build(:item_with_discount, original_price: 100.00, discount_percentage: 120) }

      it { is_expected.not_to allow_value(200).for(:discount_percentage) }

      it { expect(fake_item).not_to be_valid }
    end
  end

  describe 'Original Price' do
    context 'when original price is negativ' do
      it { is_expected.not_to allow_value(-20).for(:original_price) }
    end

    context 'when original price is not present' do
      let(:item_with_no_price) { build(:item_with_discount, original_price: '', discount_percentage: 20) }

      it { expect(item_with_no_price).not_to be_valid }
    end
  end
end
