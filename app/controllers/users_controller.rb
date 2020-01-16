class UsersController < ApplicationController
  before_action :load_user, only: :show

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:info] = t "views.users.new.sign_up_ok"
      redirect_to @user
    else
      flash.now[:danger] = t "views.users.new.create_fail"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end
end
