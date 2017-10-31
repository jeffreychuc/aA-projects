class UsersController < ApplicationController
  def new
  end

  def index
  end

  def show
    @user = current_user
    render :show
  end

  def destroy
  end

  def update
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
