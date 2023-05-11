module Owner
  class OwnerController < ApplicationController
    before_action :authenticate_user!
    before_action :authorize_owner!

    private

    def authorize_owner!
      redirect_to root_path, alert: 'Access Denied' unless current_user.owner?
    end

    def salon_owner!
      redirect_to root_path, alert: 'Access Denied' unless current_user.salons.include?(@salon)
    end

    def salon_product!
      redirect_to root_path, alert: 'Access Denied' unless current_user.salons.any? do |salon|
                                                             salon.products.include?(@product)
                                                           end
    end
  end
end
