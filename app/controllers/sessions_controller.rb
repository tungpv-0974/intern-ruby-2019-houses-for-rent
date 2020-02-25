class SessionsController < ApplicationController
  def new; end

  def create
    if params[:session]
      user = User.find_by email: params[:session][:email].downcase

      if user&.authenticate params[:session][:password]
        log_in user
        check_remember user
        redirect_back_or user
      else
        flash.now[:danger] = t "static_pages.users.login.invalid"
        render :new
      end
    else
      if user = User.from_omniauth(request.env["omniauth.auth"])
        log_in user
        remember user
        redirect_back_or user
      else
        flash.now[:danger] = t "static_pages.users.login.invalid"
        render :new
      end
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def check_remember user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
