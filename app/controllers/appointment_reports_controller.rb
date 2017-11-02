class AppointmentReportsController < ApplicationController
  def new
    @appointment_report = AppointmentReport.new
    @appointment_report.client_appointment = ClientAppointment.find(params[:client_appointment])
  end

  def create
  end

  def edit
  end

  def update
  end


end
