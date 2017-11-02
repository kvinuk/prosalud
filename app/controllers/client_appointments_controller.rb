class ClientAppointmentsController < ApplicationController
  before_action :set_client_appointment, only: [:edit, :update, :show, :destroy]
  load_and_authorize_resource

  def index
    @client_appointments = ClientAppointment.all
    @authorization = session[:authorization]
  end

  def index_calendar
    @client_appointments = ClientAppointment.all
    @authorization = session[:authorization]
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
    @calendar = @calendar_list.items.first
    rescue Google::Apis::AuthorizationError
      response = client.refresh!

      session[:authorization] = session[:authorization].merge(response)

      retry
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

  def redirect
    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s
  end

  def callback
    client = Signet::OAuth2::Client.new(client_options)
    client.code = params[:code]

    response = client.fetch_access_token!

    session[:authorization] = response

    redirect_to index_calendar_url
  end

  def calendars
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
    rescue Google::Apis::AuthorizationError
      response = client.refresh!

      session[:authorization] = session[:authorization].merge(response)

      retry
  end

  def events
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event_list = service.list_events(params[:calendar_id])
  end

  def sync
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event_list = service.list_events(params[:calendar_id])

    @event_list.items.each do |event|
      service.delete_event(params[:calendar_id], event.id)
    end 

    @client_appointments = ClientAppointment.all

    @client_appointments.each do |appointment|
      date_time = appointment.date
      # date = params[:date]
      # date_end = (date.to_time + 1.hours).to_datetime


      name_summary = appointment.full_name

      event = Google::Apis::CalendarV3::Event.new({
        start: Google::Apis::CalendarV3::EventDateTime.new(date_time: date_time),
        end: Google::Apis::CalendarV3::EventDateTime.new(date_time: date_time + 1.hours),
        summary: name_summary
    })
    end

    service.insert_event(params[:calendar_id], event)


  end

  def new_event
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client


    date = DateTime.parse(params[:date]).to_date
    date_time = DateTime.parse(params[:date])
    # date = params[:date]
    # date_end = (date.to_time + 1.hours).to_datetime


    name_summary = params[:summary]

    event = Google::Apis::CalendarV3::Event.new({
      start: Google::Apis::CalendarV3::EventDateTime.new(date_time: date_time),
      end: Google::Apis::CalendarV3::EventDateTime.new(date_time: date_time + 1.hours),
      summary: name_summary
    })

    service.insert_event(params[:calendar_id], event)

    # redirect_to events_url(calendar_id: params[:calendar_id])
  end

  private

  def client_appointment_params
    params.require(:client_appointment).permit(:client_id, :therapist_id, :consulting_room_id, 
                                               :service_id, :date, :status, :comments, :threatment_id)
  end

  def set_client_appointment
    @client_appointment = ClientAppointment.find(params[:id])
  end

  def client_options
    {
      client_id: Rails.application.secrets.google_client_id,
      client_secret: Rails.application.secrets.google_client_secret,
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
  end
end
