class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :destroy]
  load_and_authorize_resource

  def index
    @users = User.all
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path
    else
      flash.now[:danger] = @user.errors.full_messages
      render :new
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path
    else
      flash.now[:danger] = @user.errors.full_messages
      render :edit
    end
  end

  def destroy
    @user.destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_type)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
