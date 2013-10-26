class UsersController < ApplicationController

  before_filter :authenticate_user!
  # load_and_authorize_resource
  authorize_resource
  
  def index
    if admin?
      @users = User.accessible_by(current_ability, :index).order('first_name')
      respond_to do |format|
        format.html
        format.csv { send_data @users.to_csv }
      end
    else
      redirect_to directory_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    if admin?
      @user = User.new
      @user.macs.build
    else

    end
  end

  def edit
    if admin?
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end 
  end

  def create
    @user = User.new(permitted_params.users)
    if @user.save
      flash[:notice] = t 'controller.user.created', :user => @user.first_name
      redirect_to users_path
    else
      flash[:error] = t 'controller.user.not_created'
      render :action => 'new'
    end
  end

  def import
    User.import(params[:file])
    flash[:notice] = t 'controller.user.imported'
    redirect_to users_path
  end

  def update
    if admin?
      @user = User.find(params[:id])
    else
      @user = User.find(current_user.id)
    end
    params[:user].delete(:password) if params[:user][:password].blank?
    params[:user].delete(:password_confirmation) if params[:user][:password].blank? and params[:user][:password_confirmation].blank?
    if @user.update_attributes(permitted_params.users)
      flash[:notice] = t 'controller.user.updated', :user => @user.first_name
      redirect_to users_path
    else
      flash[:error] = t 'controller.user.not_updated', :user => @user.first_name
      render :action => 'edit'
    end

  end

  def destroy
    User.find(params[:id]).destroy
    respond_to do |format|
      format.js
    end
  end

end