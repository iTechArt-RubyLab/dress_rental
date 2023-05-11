class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  def show; end

  def edit
    render 'shared/users/edit'
  end

  def update
    if current_user.update(user_params)
      flash[:notice] = "Profile has been updated."
      redirect_to edit_user_path(current_user)
    else
      render :edit
      flash.now[:error] = "There was a problem updating the profile."
    end
  end

  def request_owner_access
    UserMailer.request_owner_access(current_user).deliver_now
    redirect_to user_path(current_user)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :email, :phone_number, :password, :password_confirmation, :role, :avatar)
  end
end
