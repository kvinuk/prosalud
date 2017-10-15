class ClientAppointmentsController < ApplicationController
  before_action :set_client_appointment, only: [:edit, :update, :show, :destroy]
  load_and_authorize_resource

  def index
    @client_appointments = ClientAppointment.all
  end

  def new
    @client_appointment = ClientAppointment.new
  end

  def create
    @client_appointment = ClientAppointment.new(client_appointment_params)
    if @client_appointment.save
      redirect_to client_appointments_path
    else
      flash.now[:danger] = @client_appointment.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @client_appointment.update(client_appointment_params)
      redirect_to client_appointments_path
    else
      flash.now[:danger] = @client_appointment.errors.full_messages
      render :edit
    end
  end

  def destroy
    @client_appointment.destroy
  end

  private

  def client_appointment_params
    params.require(:client_appointment).permit(:client_id, :therapist_id, :consulting_room_id, 
                                               :service_id, :date, :status, :comments, :threatment_id)
  end

  def set_client_appointment
    @client_appointment = ClientAppointment.find(params[:id])
  end
end
