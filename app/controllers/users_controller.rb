class UsersController < ApplicationController
  before_action :set_user, only: %i(show)

  def show
    @user = User.find_by id: params[:id]
    return if @user

    flash[:warning] = t("controller.user_c.user_not_found")
    redirect_to root_path
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      # something
      flash[:success] = t("controller.user_c.u_create_success")
      redirect_to @user
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def set_user
    @user = User.find_by id: params[:id]
  end

  def user_params
    params.require(:user).permit :name, :email, :password,
                                 :password_confirmation
  end
end
