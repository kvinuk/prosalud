class ChannelsController < ApplicationController
  before_action :set_channel, only: [:edit, :update, :show, :destroy]

  def index
    @channels = Channel.all
  end

  def show
  end

  def new
    @channel = Channel.new
  end

  def create
    @channel = Channel.new(channel_params)
    if @channel.save
      redirect_to new_channel_path
    else
      flash.now[:danger] = @channel.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @channel.update(channel_params)
      redirect_to new_channel_path
    else
      flash.now[:danger] = @channel.errors.full_messages
      render :edit
    end
  end

  def destroy
    @channel.destroy
  end

  private

  def channel_params
    params.require(:channel).permit(:name)
  end

  def set_channel
    @channel = Channel.find(params[:id])
  end
end
