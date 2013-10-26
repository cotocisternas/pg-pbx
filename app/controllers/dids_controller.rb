class DidsController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource
  
  def index
    @dids = Did.accessible_by(current_ability, :index).order('did')
    respond_to do |format|
      format.html
      format.csv { send_data @dids.to_csv }
    end
  end

  def show
    @did = Did.find(params[:id])
  end

  def new
    @did = Did.new
    @extensions = Extension.all
  end

  def edit
    @did = Did.find(params[:id])
    @extensions = Extension.all
  end

  def create
    @did = Did.new(permitted_params.did)
    if @did.save
      flash[:notice] = t 'controller.did.created', :did => @did.did
      redirect_to dids_path
    else
      flash[:error] = t 'controller.did.not_created'
      render :action => 'new'
    end
  end

  def import
    Did.import(params[:file])
    flash[:notice] = t 'controller.did.imported'
    redirect_to dids_path
  end

  def update
    @did = Did.find(params[:id])
    if @did.update_attributes(permitted_params.did)
      flash[:notice] = t 'controller.did.updated', :did => @did.did
      redirect_to dids_path
    else
      flash[:error] = t 'controller.did.not_updated', :did => @did.did
      render :action => 'edit'
    end

  end

  def destroy
    Did.find(params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end

end