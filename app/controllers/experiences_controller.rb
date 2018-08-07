class ExperiencesController < ApplicationController
  before_action :find_experience, only: [ :show, :edit, :update, :destroy ]
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    @experiences = policy_scope(Experience).order(created_at: :desc)
    if params[:query].present?
      sql_query = " \
        experiences.name @@ :query \
        OR experiences.description @@ :query \
        OR  users.first_name @@ :query \
        OR  users.last_name @@ :query \
      "
      @experiences = Experience.joins(:user).where(sql_query, query: "%#{params[:query]}%")
    else
      @experiences = Experience.all
    end
  end

  def show
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
    params.require(:experience).permit(:name, :description, :price, :capacity)
  end
end
