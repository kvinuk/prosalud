class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from CanCan::AccessDenied do |exception|
    flash.now[:danger] = ["No tienes nivel de acceso necesario", exception.message]
    redirect_to new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    channels_path
  end

  def after_sign_out_path_for(resource_or_scope)
    root_path
  end
end
