class AuthedController < ApplicationController
  before_action :require_login
end
