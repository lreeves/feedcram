class ApplicationController < ActionController::Base
  before_action :require_login

  attr_reader :current_user

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def require_login
    unless session[:user_id].present?
      flash[:error] = "You must be logged in to access this section"
      return redirect_to '/'
    end

    @current_user = User.find session[:user_id]
  end
end
