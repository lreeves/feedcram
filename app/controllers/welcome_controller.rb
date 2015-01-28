class WelcomeController < ApplicationController
  skip_before_action :require_login

  def index
    if session[:user_id].present?
      return redirect_to '/dashboard'
    end
  end
end
