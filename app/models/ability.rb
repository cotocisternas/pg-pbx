class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin
      can :manage, :all
    end
    if user.has_role? :user
      # Dashboard Controller
      can [:index,:show], :dashboard
      # Directory Controller
      can [:index, :show], :directory
      # User Controller
      can [:edit,:update], User, :id => user.id
      can [:index,:show], User
      # Extension Controller
      # can :read, Extension, :user_id => user.id
      # Cdr Controller
      can :read, Cdr, :src => user.extension.name if user.extension
    end
  end
  
end
    