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
    reservation_time = Time.zone.now
    if reservation_time.min <= 30
      reservation_time = reservation_time + (30 - reservation_time.min).minutes
    else
      reservation_time = reservation_time + (60 - reservation_time.min).minutes
    end
    @consulting_rooms = ConsultingRoom.available_rooms(reservation_time)
    @therapists = Therapist.available_therapists(reservation_time)
  end

  def create
    @client_appointment = ClientAppointment.new(client_appointment_params)
    @second_client_appointment = ClientAppointment.new(client_appointment_params)

    case @client_appointment.treatment 
      when "Semanal"
        @second_client_appointment.date = @client_appointment.date + 1.week
      when "Quincenal"
        @second_client_appointment.date = @client_appointment.date + 2.weeks
      when "Mensual"
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
    @consulting_rooms = ConsultingRoom.all
    @therapists = Therapist.all
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
    redirect_to client_appointments_path
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

    redirect_to sync_url
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
    @client_appointments = ClientAppointment.all

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
    @calendar = @calendar_list.items.first

    @event_list = service.list_events(@calendar.id)

    @client_appointments = ClientAppointment.all

    @client_appointments.each do |appointment|
      unless appointment.event_id.blank?
        @get_event = service.get_event(@calendar.id, appointment.event_id)
        unless @get_event.status == 'cancelled'
          service.delete_event(@calendar.id, appointment.event_id)
        end
        appointment.update_attribute(:event_id,nil)
        # puts 'delete event'+appointment.event_id.blank?
      end
      date_time = DateTime.parse(appointment.date.to_s)

      name_summary = appointment.client.full_name
      description = appointment.service.name
      location = appointment.consulting_room.name
      event = Google::Apis::CalendarV3::Event.new({
          start: Google::Apis::CalendarV3::EventDateTime.new(date_time: date_time),
          end: Google::Apis::CalendarV3::EventDateTime.new(date_time: date_time + 1.hours),
          summary: name_summary,
          description: description,
          location: location
      })

      @new_event = service.insert_event(@calendar.id, event)
      appointment.update_attribute(:event_id,@new_event.id)
    end
    flash[:success] = ['Sincronización exitosa']
    redirect_to client_appointments_path

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

  def available_rooms
    date = "#{params[:year]}-#{params[:month]}-#{params[:day]} #{params[:hour]}:#{params[:minutes]}"
    reservation_time = Time.zone.parse(date)
    @consulting_rooms = ConsultingRoom.available_rooms(reservation_time)
    @therapists = Therapist.available_therapists(reservation_time)
  end

  private

  def client_appointment_params
    params.require(:client_appointment).permit(:client_id, :therapist_id, :consulting_room_id, 
                                               :service_id, :date, :status, :comments, :treatment)
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
