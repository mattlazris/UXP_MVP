class PagesController < ApplicationController
  before_action :find_current_user, only: [ :profile ]
  skip_before_action :authenticate_user!, only: [ :home, :host ]

  def home
    redirect_to experiences_path
  end

  def profile
    @attended_bookings = []
    @attending_bookings = []
    @attended_bookings += @user.bookings.select { |booking| booking.finished }
    @attending_bookings += @user.bookings.reject { |booking| booking.finished }

    @hosted_bookings = []
    @hosting_bookings = []
    @user.experiences.each do |exp|
      @hosted_bookings += exp.bookings.select { |booking| booking.finished }
      @hosting_bookings += exp.bookings.reject { |booking| booking.finished }
    end
  end

  def host
    @experience = Experience.find(params[:experience_id])
    @host = @experience.user
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
