class PermittedParams < Struct.new(:params, :user)
  def users
    if user.has_role? :admin
      params.require(:user).permit!
    else
      params.require(:user).permit(:password, :password_confirmation, :remember_me)
    end
    # params.require(:user).permit(*users_attributes)
  end

  # def users_attributes
  #   if user.has_role? :admin
  #     [ :first_name, :last_name, :email, :password, :password_confirmation, :remember_me, 
  #       :role_ids, :department_id, :port_id, :company_id, macs_attributes: [:name, :ip, :user_id, :id, :_destroy]]
  #   elsif
  #     [:password, :password_confirmation, :remember_me]
  #   end
  # end

  def extension
    params.require(:extension).permit(*extension_attributes)
  end

  def extension_attributes
    if user.has_role? :admin
      [:name, :secret, :defaultuser, :callerid, :context, :user_id, :dialplan_id, :company_id, :department_id]
    end
  end

  def did
    params.require(:did).permit(*did_attributes)
  end

  def did_attributes
    if user.has_role? :admin
      [:did, :app, :app_arg]
    end
  end

  def search
    params.require(:search).permit! if user.has_role? :admin
  end

  # def port_attributes
  #   if user.has_role? :admin
  #     [:switch_id, :port_number, :port_sw_number, :speed]
  #   end
  # end

  # def mac_attributes
  #   if user.has_role? :admin
  #     [:name, :ip, :user_id, :id, '_destroy']
  #   end
  # end
end