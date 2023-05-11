module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!

    private

    def authorize_admin!
      redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
    end
  end
end
