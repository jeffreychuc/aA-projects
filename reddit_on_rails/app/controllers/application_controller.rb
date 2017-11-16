class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user

  def login(user)
    @current_user = user
    session[:session_token] = current_user.session_token
  end

  def logout
    current_user.reset_session_token
    session[:session_token] = nil
  end

  def logged_in?
    !!current_user
  end

  def require_logged_in
    if !logged_in?
      flash[:errors] = ["You must be logged in for that."]
      redirect_to new_session_url
    end
  end

  def require_logged_out
    if logged_in?
      flash[:errors] = ["You can't be logged in for that."]
      redirect_to users_url
    end
  end

  def current_user
    @current_user ||= User.find_by(session_token: session[:session_token])
  end
end
