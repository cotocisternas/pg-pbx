class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :set_locale
  helper_method :admin?
  helper_method :user?
  helper_method :permitted_params

  rescue_from CanCan::AccessDenied do |exception|
    Rails.logger.debug "Access denied. (Action: #{exception.action}, Resource: #{exception.subject})"
    if ! user_signed_in?
      redirect_to root_url, :alert => exception.message
    else
      render({
        :status => 403,
        :file   => "#{Rails.root}/app/views/403",
        :layout => true,
        :locals => { :exception => exception },
      })
    end
  end

  def admin?
    current_user.has_role? :admin
  end

  def user?
    current_user.has_role? :user
  end

  def permitted_params
    @permitted_params ||= PermittedParams.new(params, current_user)
  end

  def after_sign_in_path_for(resource)
    root_path
  end
 
  def set_locale
    I18n.locale = params[:locale] || I18n.default_locale
  end
end
