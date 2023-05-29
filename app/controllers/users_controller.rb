class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]

  def show; end

  def edit
    render 'shared/users/edit'
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: 'Profile has been updated.'
    else
      render 'shared/users/edit', alert: 'There was a problem updating the profile.'
    end
  end

  def request_owner_access
    RequestOwnerAccessWorker.perform_async(current_user.id)
    redirect_to user_path(current_user), notice: 'Request letter was send to admin. Thank you for trusting us!'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone_number, :password, :password_confirmation, :role, :avatar,
                                 :rating)
  end
end
