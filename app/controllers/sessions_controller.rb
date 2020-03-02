class SessionsController < ApplicationController
  def new; end

  def create
    status = params[:session] ? authentication_email_password : authentication_facebook

    if status
      log_in @user
      redirect_back_or @user
    else
      flash.now[:danger] = t "static_pages.users.login.invalid"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end

  private

  def authentication_facebook
    @user = User.from_omniauth(request.env["omniauth.auth"])
  end

  def authentication_email_password
    @user = User.find_by email: params[:session][:email].downcase
    if @user&.authenticate params[:session][:password]
      check_remember @user
      return true
    end
  end

  def check_remember user
    params[:session][:remember_me] == "1" ? remember(user) : forget(user)
  end
end
