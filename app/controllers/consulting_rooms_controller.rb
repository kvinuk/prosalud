class ConsultingRoomsController < ApplicationController
  before_action :set_consulting_room, only: [:edit, :update, :show, :destroy]
  load_and_authorize_resource

  def index
    @consulting_rooms = ConsultingRoom.all
  end

  def new
    @consulting_room = ConsultingRoom.new
  end

  def create
    @consulting_room = ConsultingRoom.new(consulting_room_params)
    if @consulting_room.save
      redirect_to consulting_rooms_path
    else
      flash.now[:danger] = @consulting_room.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @consulting_room.update(consulting_room_params)
      redirect_to consulting_rooms_path
    else
      flash.now[:danger] = @consulting_room.errors.full_messages
      render :edit
    end
  end

  def destroy
    @consulting_room.destroy
    redirect_to consulting_rooms_path 
  end

  private

  def consulting_room_params
    params.require(:consulting_room).permit(:name, :room_type)
  end

  def set_consulting_room
    @consulting_room = ConsultingRoom.find(params[:id])
  end
end