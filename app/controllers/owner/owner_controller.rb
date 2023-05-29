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
      unless current_user.salons.joins(:products).where(products: {id: @product.id}).exists?
        redirect_to root_path, alert: 'Access Denied'
      end
    end
  end
end
