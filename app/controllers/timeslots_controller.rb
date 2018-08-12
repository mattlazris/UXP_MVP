class TimeslotsController < ApplicationController
  before_action :find_timeslot, only: [ :show, :edit, :update, :destroy ]

  def index
    @timeslots = Timeslot.all
  end

  def show
  end

  def new
    @timeslot = Timeslot.new
    authorize @timeslot
    @experience = Experience.find(params[:experience_id])
  end

  def create
    @experience = Experience.find(params[:experience_id])
    @timeslot = Timeslot.new(timeslot_params)
    authorize @timeslot
    @timeslot.end_time = (@timeslot.start_time.to_time + @experience.duration.hours).to_datetime
    @timeslot.experience = @experience
    if @timeslot.save
      redirect_to experience_path(@experience)
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @timeslot.update(timeslot_params)
      redirect_to profile_path
    else
      render :edit
    end
  end

  def destroy
    @timeslot.destroy
    redirect_to profile_path
  end

  private
  def find_timeslot
    @timeslot = authorize Timeslot.find(params[:id])
  end

  def timeslot_params
    params.require(:timeslot).permit(:start_time, :end_time)
  end
end
