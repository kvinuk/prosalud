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
    @second_client_appointment = ClientAppointment.new(client_appointment_params)

    case @client_appointment.threatment # a_variable is the variable we want to compare
      when "Semanal"    #compare to 1
        @second_client_appointment.date = @client_appointment.date + 1.week
      when "Quincenal"     #compare to 2
        @second_client_appointment.date = @client_appointment.date + 2.weeks
      when "Mensual"     #compare to 2
        @second_client_appointment.date = @client_appointment.date + 1.month
    end
  
    if @client_appointment.save 
      if @second_client_appointment.save

        flash.now[:success] = ["Ambas citas han sido creadas"]
      else
        flash.now[:danger] = ["No se pudo crear la próxima cita"]

      end
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

  def available_rooms
    date = "#{params[:year]}-#{params[:month]}-#{params[:day]} #{params[:hour]}:#{params[:minutes]}"
    reservation_time = Time.zone.parse(date)
    @consulting_rooms = ConsultingRoom.available_rooms(reservation_time)
    @therapists = Therapist.available_therapists(reservation_time)
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
