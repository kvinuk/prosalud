class SchedulesController < ApplicationController
	before_action :set_schedule, only: [:edit, :update, :show, :destroy]
	load_and_authorize_resource
	
	def index
		@schedules = Schedule.all
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
		params.require(:schedule).permit(:start_time, :end_time, :week_day)
	end

	def set_schedule
		@schedule = Schedule.find(params[:id])
	end
end
