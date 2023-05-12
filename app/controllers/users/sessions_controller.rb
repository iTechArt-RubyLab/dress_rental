# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  def after_sign_out_path_for(_resource_or_scope)
    new_user_session_path
  end

  def after_sign_in_path_for(resource_or_scope)
    stored_location_for(resource_or_scope) || root_path
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user.valid_password?(params[:user][:password])
      if user.confirmed?
        sign_in(user)
      else
        flash[:error] = 'Your account is not yet confirmed'
      end
      redirect_to root_path
    else
      flash[:error] = 'Invalid email or password'
    end
  end
end
