class SessionsController < ApplicationController
  before_action :require_logged_out, only: [:new, :create]
  def new
  end

  def create
    user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if user
      login(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ["Invalid Login"]
      render :new
    end
  end

  def destroy
    logout
    redirect_to root_url
  end
end
