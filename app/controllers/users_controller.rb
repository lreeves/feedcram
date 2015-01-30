class UsersController < ApplicationController
  skip_before_action :require_login

  def new
    @user = User.new
  end

  def create
    User.create(user_params)
  end

  def login
  end

  def authenticate
    u = User.find_by_email(login_params[:email])

    unless u.blank?
      if u.authenticate(login_params[:password])
        session[:user_id] = u.id
        return redirect_to '/read'
      end
    end

    render :failure
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
