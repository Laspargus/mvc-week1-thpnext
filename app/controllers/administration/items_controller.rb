# frozen_string_literal: true

module Administration
  class ItemsController < AdministrationController
    before_action :authenticate_admin!

    def index
      @emails = User.emails_of_all_users
      @items = Item.all
    end

    def update
      @item = Item.find(params[:id])
      @item.update(discount_percentage: params[:item]['discount_percentage'], has_discount: true) if params[:item]['discount_percentage'] != 0
      redirect_to administration_items_path
    end
  end
end
