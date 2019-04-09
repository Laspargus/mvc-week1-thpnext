# frozen_string_literal: true

module ControllerMacros
  def login_admin
    before do
      @request.env["devise.mapping"] = Devise.mappings[:admin]
      sign_in FactoryBot.create(:admin) # Using factory bot as an example
    end
  end
end
