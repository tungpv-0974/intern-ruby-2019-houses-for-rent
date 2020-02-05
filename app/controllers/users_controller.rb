class UsersController < ApplicationController
  before_action :load_user, only: %i(show edit update)
  before_action :logged_in_user, :correct_user, only: %i(edit update)

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

  def edit
    @provinces = Province.all.pluck(:name, :id).to_a
    @districts = @user.districts&.pluck(:name, :id).to_a
    @wards = @user.wards&.pluck(:name, :id).to_a
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "views.users.edit.update_success"
      redirect_to @user
    else
      flash.now[:danger] = t "views.users.edit.update_fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit User::USER_PARAMS
  end

  def correct_user
    redirect_to root_path unless current_user? @user
  end
end
