class DirectoryController < ApplicationController

  before_filter :authenticate_user!
  authorize_resource :class => false

  def index
    @users = User.accessible_by(current_ability, :index).order("first_name")
  end

  def show
    @user = User.find(params[:id])
    if @user.extension
      extension = @user.extension.name
      @cdrs = Cdr.where('disposition = ? AND (src = ? OR dst = ?)', 'ANSWERED',extension,extension).limit(7).order('calldate DESC')
    end
  end
end
