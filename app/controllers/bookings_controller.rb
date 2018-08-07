class BookingsController < ApplicationController
  before_action :find_booking, only: [ :show, :edit, :update, :destroy ]

  def index
    @bookings = Booking.all
  end

  def show
    @booking = Booking.find(params[:id])
    authorize @booking
  end

  def new
    @booking = Booking.new
    authorize @booking
    @experience = Experience.find(params[:experience_id])
  end

  def create
    @experience = Experience.find(params[:experience_id])
    @booking = Booking.new(booking_params)
    authorize @booking
    @booking.experience = @experience
    @booking.user = current_user
    if @booking.save
      redirect_to experience_booking_path(@experience, @booking)
    else
      render :new
    end
  end

  def edit
    @booking.finished = true
    @booking.save
    redirect_to profile_path
  end

  def update
  end

  def destroy
    @booking.destroy
    redirect_to profile_path
  end

  private
  def find_booking
    @booking = authorize Booking.find(params[:id])
  end

  def booking_params
    params.require(:booking).permit(:start_time, :end_time, :finished)
  end
end
