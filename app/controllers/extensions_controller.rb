class ExtensionsController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource

  def index
    @extensions = Extension.accessible_by(current_ability, :index).order('name')
  end

  def show
    @extension = Extension.find(params[:id])
  end

  def new
    @extension = Extension.new
    dialplans = Dialplan.all
    contexts = []
    dialplans.group_by(&:context).map {|k,v| [k,v]}.each do |d|
      contexts << d.first
    end
    @destinations = contexts
  end

  def edit
    @extension = Extension.find(params[:id])
    dialplans = Dialplan.all
    contexts = []
    dialplans.group_by(&:context).map {|k,v| [k,v]}.each do |d|
      contexts << d.first
    end
    @destinations = contexts
  end

  def create
    @extension = Extension.new(permitted_params.extension)
    if @extension.save
      flash[:notice] = t 'controller.extension.created', :extension => @extension.name
      redirect_to extensions_path
    else
      flash[:error] = t 'controller.extension.not_created'
      render :action => 'new'
    end
  end

  def update
    @extension = Extension.find(params[:id])
    if @extension.update_attributes(permitted_params.extension)
      flash[:notice] = t 'controller.extension.updated', :extension => @extension.name
      redirect_to extensions_path
    else
      flash[:error] = t 'controller.extension.not_updated', :extension => @extension.name
      render :action => 'edit'
    end
  end

  def destroy
    Extension.find(params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end
  
end