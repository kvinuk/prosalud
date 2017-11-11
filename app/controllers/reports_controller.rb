class ReportsController < ApplicationController
  authorize_resource class: false

  def index
    if !params[:start_date] && !params[:end_date]
      @appointments = ClientAppointment.all
    else
      start_date_hash = params[:start_date]
      end_date_hash = params[:end_date]
      start_date = Date.new start_date_hash["start_date(1i)"].to_i, start_date_hash["start_date(2i)"].to_i, start_date_hash["start_date(3i)"].to_i
      end_date = Date.new end_date_hash["end_date(1i)"].to_i, end_date_hash["end_date(2i)"].to_i, end_date_hash["end_date(3i)"].to_i
      @appointments = ClientAppointment.where(date: start_date.beginning_of_day..end_date.end_of_day)
    end
  end

end