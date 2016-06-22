class SessionsController < ApplicationController
  skip_before_filter :require_login

  def new

  end

  def create
    user = User.find_by(mail: params[:mail]) #|| User.find_by(name: params[:name])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: 'Logged in!'
    else
      redirect_to root_url
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: 'Logged out!'
  end
end
