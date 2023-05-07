module Admin
  class AdminController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_admin!
    before_action :admin_namespace

    private

    def authorize_admin!
      redirect_to root_path, alert: 'Access Denied' unless current_user.admin?
    end

    def admin_namespace
      @namespace = :admin
    end
  end
end