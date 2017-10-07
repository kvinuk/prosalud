class ServicesController < ApplicationController
  before_action :set_service, only: [:edit, :update, :show, :destroy]
  load_and_authorize_resource

  def index
    @services = Service.all
  end

  def show
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to new_service_path
    else
      flash.now[:danger] = @service.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @service.update(service_params)
      redirect_to new_service_path
    else
      flash.now[:danger] = @service.errors.full_messages
      render :edit
    end
  end

  def destroy
    @service.destroy
  end

  private

  def service_params
    params.require(:service).permit(:name, :initial_price, :subsequent_price, :community_price)
  end

  def set_service
    @service = Service.find(params[:id])
  end
end
