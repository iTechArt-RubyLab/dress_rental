module Admin
  class UsersController < AdminController
    before_action :set_user, only: %i[show edit update confirm_owner destroy]

    def index
      @users = User.all
    end

    def show; end

    def edit
      render 'shared/users/edit'
    end

    def update
      if @user.update(user_params)
        redirect_to edit_user_path(@user), notice: 'Profile successfully updated.'
      else
        render :edit
        flash.now[:error] = 'Could not save the changes.'
      end
    end

    def confirm_owner
      if @user.update(role_type: :owner)
        redirect_to admin_users_path, notice: 'User successfully updated.'
      else
        redirect_to admin_users_path, notice: "Couldn't update user's role."
      end
    end

    def destroy
      @user.destroy

      respond_to do |format|
        format.html { redirect_to admin_users_url, notice: 'User was successfully destroyed.' }
      end
    end

    private

    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:username, :email, :phone_number, :password, :role, :avatar)
    end
  end
end
