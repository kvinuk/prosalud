class TreatmentsController < ApplicationController
  before_action :set_treatment, only: [:edit, :update, :show, :destroy]
  load_and_authorize_resource

  def index
    @treatments = Treatment.all
  end

  def show
  end

  def new
    @treatment = Treatment.new
  end

  def create
    @treatment = Treatment.new(treatment_params)
    if @treatment.save
      redirect_to treatments_path
    else
      flash.now[:danger] = @treatment.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @treatment.update(treatment_params)
      redirect_to treatments_path
    else
      flash.now[:danger] = @treatment.errors.full_messages
      render :edit
    end
  end

  def destroy
    @treatment.destroy
    redirect_to treatments_path

  end

  private

  def treatment_params
    params.require(:treatment).permit(:start_date, :end_date, :client_id, :therapist_id)
  end

  def set_treatment
    @treatment = Treatment.find(params[:id])
  end
end
