class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find(params[:username])
    if user #&& user.authenticate(params[:password])
      if
      session[:user_id] = user.username
      session[:passwd] = params[:passwd]
        redirect_to root_url, :notice => "Logged in!"
      end
    else
      flash.now.alert = "Wrong login!"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    session[:passwd]  = nil
    redirect_to root_url, :notice => "Logged out!"
  end
end
