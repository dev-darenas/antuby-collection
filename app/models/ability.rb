# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    if user.enterprise.active?
      if user.has_role?(:collection_advisor)
        ## TODO manage accion to collection_advisor
        can :manage, :all
      elsif user.has_role?(:debt_collector)
        ## TODO manage accion to debt_collector
        can :manage, :all
      end
    end

    if user.has_role?(:admin) && user.enterprise.active?
      can :manage, :all
    elsif user.has_role?(:admin) && user.enterprise.pay_pending?
      can :manage, AdminInvoice
    end
  end
end
