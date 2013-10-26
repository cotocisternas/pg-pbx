class DashboardController < ApplicationController
  
  before_filter :authenticate_user!
  authorize_resource :class => false

  def index
    if user? && !admin?
      redirect_to member_path(current_user)
    end
  end
end
