class Admin::BaseController < ApplicationController
  before_action :authenticate_user!, :authenticate_admin!

  layout 'admin_landing'

  def authenticate_admin!
    #TODO
  end
end