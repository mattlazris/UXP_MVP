class ExperiencesController < ApplicationController
  before_action :find_experience, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @experiences = policy_scope(Experience).order(created_at: :desc)
    @top_experiences = Experience.all.sample(3)
    @basketball_experiences = Experience.all.select { |exp| exp.category == 'Basketball' }
    @top_basketball_experiences = @basketball_experiences.sample(3)
    @soccer_experiences = Experience.all.select { |exp| exp.category == 'Soccer' }
    @top_soccer_experiences = @soccer_experiences.sample(3)
    @tennis_experiences = Experience.all.select { |exp| exp.category == 'Tennis' }
    @top_tennis_experiences = @tennis_experiences.sample(3)
  end

  def show
    @marker = Experience.where(id: params[:id]).map do |exp|
      {
        lat: exp.latitude,
        lng: exp.longitude,
        # infoWindow: { content: render_to_string(partial: "/flats/map_box", locals: { flat: flat }) }
      }
    end
  end

  def new
    if current_user.host?
      @experience = Experience.new
      authorize @experience
    else
      redirect_to profile_path
    end
  end

  def create
    @experience = Experience.new(experience_params)
    authorize @experience
    @experience.user = current_user
    if @experience.save
      redirect_to profile_path
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @experience.update(experience_params)
      redirect_to @experience
    else
      render :edit
    end
  end

  def destroy
    @experience.destroy
    redirect_to profile_path
  end

  private
  def find_experience
    @experience = authorize Experience.find(params[:id])
  end

  def experience_params
    params.require(:experience).permit(:name, :description, :price, :capacity, :photo, :location, :language, :category, :venue, :skill_level, :duration, :tag_list => [])
  end
end
