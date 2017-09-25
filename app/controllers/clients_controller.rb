class ClientsController < ApplicationController
  before_action :set_client, only: [:edit, :update, :show, :destroy]
  load_and_authorize_resource

  def index
    @clients = Client.all
  end

  def show
  end

  def new
    @client = Client.new
  end

  def create
    @client = Client.new(client_params)
    if @client.save
      redirect_to new_client_path
    else
      flash.now[:danger] = @client.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @client.update(client_params)
      redirect_to new_client_path
    else
      flash.now[:danger] = @client.errors.full_messages
      render :edit
    end
  end

  def destroy
    @client.destroy
  end

  private

  def client_params
    params.require(:client).permit(:fname, :lname, :folio, :street, :neighborhood, :city, 
                                   :zipcode, :house_phone, :mobile_phone, :age, :tutor_name, 
                                   :contact_date, :observations, :channel_id)
  end

  def set_client
    @client = Client.find(params[:id])
  end
end
