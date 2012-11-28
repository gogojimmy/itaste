class Ability
  include CanCan::Ability

  def initialize(user)
    user || User.new

    if user.try(:is_admin?)
      can :manage, :all
    else
      can :read, :all
      can :create, Wine
      can :update, Wine do |wine|
        wine.try(:user) == user
      end
      can :create, Food
      can :create, Grape
      can :create, List
      can :update, List do |list|
        list.try(:user) == user
      end
      can :create, Place
      can :create, Producer
      can :create, Region
    end
  end
end
