class SubsController < ApplicationController
  before_action :require_logged_in
  def new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit

  end

  def update
    @sub = current_user.subs.find(params[:id])
    if @sub.update(something_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def index
  end

  def destroy
    @sub = current_user.subs.find(params[:id])
    if @sub.destroy
      redirect_to subs_url
    else
      flash[:errors] = ["Errors occured!"]
      redirect_to sub_show(@sub)
    end
  end

  def show
    @sub = Sub.find(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:title, :description)
  end
end
