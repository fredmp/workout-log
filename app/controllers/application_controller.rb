class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end

  def set_locale
    # request.env['HTTP_ACCEPT_LANGUAGE'].match(/(pt|pt-BR)/)
    
    # I18n.locale = params[:locale] || I18n.default_locale
    I18n.locale = :en

    # user_locale = current_user.locale if current_user
    # I18n.locale = user_locale || I18n.default_locale
  end
end
