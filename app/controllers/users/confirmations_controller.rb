# frozen_string_literal: true

class Users::ConfirmationsController < Devise::ConfirmationsController
  def show
    self.resource = resource_class.confirm_by_token(params[:confirmation_token])
    yield resource if block_given?

    if resource.errors.empty?
      flash[:success] = "Your account has been successfully confirmed."
      sign_in(resource)
      redirect_to root_url
    else
      flash[:error] = "Invalid confirmation token."
      redirect_to root_url
    end
  end
end
