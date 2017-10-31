class SessionsController < ApplicationController
  def new
  end

  def edit

  end

  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      session[:session_token] = @user.session_token
      redirect_to user_url(@user)
    else
      flash[:errors] = ['Invalid username or password']
      render :new
    end
  end

  def update

  end

  def destroy
    @user = User.f

  end

  def index

  end
end
