class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def admin_user
    unless current_user and current_user.admin?
      redirect_to root_url
    end
  end

  def logged_user
    redirect_to root_url, alert: "Please login, or use a Guest account." if current_user.nil?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end
