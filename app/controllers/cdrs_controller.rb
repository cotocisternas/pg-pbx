class CdrsController < ApplicationController

  before_filter :authenticate_user!
  load_and_authorize_resource

  def index
    respond_to do |wants|
      wants.html
      wants.json { render json: CdrsDatatable.new(view_context) }
    end    
  end
end
