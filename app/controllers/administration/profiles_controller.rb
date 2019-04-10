# frozen_string_literal: true

module Administration
  class ProfilesController < ApplicationController
    def show; end

    def send_email
      @user = User.find(params[:id])
      notify_user(@user)
      redirect_back fallback_location: root_path
    end

    def index
      @user = User.all
    end

    private

    def set_profile
      @profile = Profile.find(params[:id])
    end

    def notify_user(user)
      ProfileMailer.notify_user(user).deliver_now
    end
  end
end
