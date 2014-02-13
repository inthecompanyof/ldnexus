class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception

  include StaticRoutes
  before_filter :login_required

  private

  def login_required
    redirect_to login_path unless logged_in?
  end

  def logged_in?
    current_user.present?
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user ||= session[:user_id] && User.find(session[:user_id])
  end

end
