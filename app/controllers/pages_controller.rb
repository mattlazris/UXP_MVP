class PagesController < ApplicationController
  before_action :find_current_user, only: [ :profile ]
  skip_before_action :authenticate_user!, only: [:home]

  def home
    redirect_to experiences_path
  end

  def profile
  end

  private
  def find_current_user
    if user_signed_in?
      @user = current_user
    else
      redirect_to new_user_session_path
    end
  end
end
