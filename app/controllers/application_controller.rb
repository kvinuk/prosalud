class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:danger] = ["No tienes nivel de acceso necesario", exception.message]
    redirect_to new_user_session_path
  end
end
