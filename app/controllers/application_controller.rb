class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  helper_method :current_user, :logged_in?
  before_action :check_logged_in

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def check_logged_in
    check_controller_list = %w(tags todos)
    redirect_to(login_url) if check_controller_list.include?(params[:controller]) && !logged_in?
  end
end
