class DialplansController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    @dialplans = Dialplan.accessible_by(current_ability, :index)
    @extensions = Extension.accessible_by(current_ability, :index)
    @destinations = @dialplans.group_by(&:context).map {|k,v| [k,v]}
  end

end
