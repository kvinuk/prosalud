class AppointmentReportsController < ApplicationController
  before_action :set_appointment_report, only: [:edit, :update]
  load_and_authorize_resource
  
  def new
    @appointment_report = AppointmentReport.new
    @appointment_report.client_appointment = ClientAppointment.find(params[:client_appointment])
  end

  def create
    @appointment_report = AppointmentReport.new(appointment_report_params)
    if @appointment_report.save
      redirect_to client_appointments_path
    else
      flash.now[:danger] = @appointment_report.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @appointment_report.save
      redirect_to client_appointments_path
    else
      flash.now[:danger] = @appointment_report.errors.full_messages
      render :edit
    end
  end

  private

  def appointment_report_params
    params.require(:appointment_report).permit(:therapist_assistance, :client_assistance, 
                                               :delay_responsible, :start_hour, :client_appointment_id)
  end

  def set_appointment_report
    @appointment_report = AppointmentReport.find(params[:id])
  end


end
