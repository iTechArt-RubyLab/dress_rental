class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show; end

  def new
    @user = User.new
  end

  def edit; end

  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        UserMailer.email_confirmation(@user).deliver_now
        flash[:notice] = "Please confirm your email address to activate your account"
        format.html { redirect_to user_url(@user), notice: "User was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if current_user.update(user_params)
      flash[:success] = "Your profile has been updated."
      redirect_to edit_user_path(current_user)
    else
      render :edit
      flash.now[:error] = "There was a problem updating your profile."
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation, :role, :avatar)
  end
end
