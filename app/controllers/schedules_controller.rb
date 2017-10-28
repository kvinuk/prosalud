class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:edit, :update, :show, :destroy]
  before_action :set_therapists, only: [:new, :edit, :create, :update]
  load_and_authorize_resource
  
  def index
    @schedules = Schedule.all
    @schedules = current_user.therapist.schedules if current_user.has_role? :therapist
  end

  def show
  end

  def new
    @schedule = Schedule.new
  end

  def create
    @schedule = Schedule.new(schedule_params)
    if @schedule.save
      redirect_to new_schedule_path
    else
      flash.now[:danger] = @schedule.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @schedule.update(schedule_params)
      redirect_to new_schedule_path
    else
      flash.now[:danger] = @schedule.errors.full_messages
      render :edit
    end
  end

  def destroy
    @schedule.destroy
  end

  private

  def schedule_params
    params.require(:schedule).permit(:start_time, :end_time, :week_day, :therapist_id)
  end

  def set_schedule
    if current_user.has_role? :therapist
      @schedule = current_user.therapist.schedules.find(params[:id])
    else
      @schedule = Schedule.find(params[:id])
    end
  end

  def set_therapists
    if current_user.has_role? :therapist
      @therapists = [current_user.therapist]
    else
      @therapists = Therapist.all
    end
  end
end
