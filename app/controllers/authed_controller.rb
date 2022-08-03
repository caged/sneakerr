class AuthedController < ApplicationController
  before_action :require_login
  before_action :set_cart 

  private 

  def set_cart 
    @cart = Cart.find_or_create_by(user_id: current_user.id)
  end
end
