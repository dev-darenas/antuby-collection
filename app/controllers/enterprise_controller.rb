class EnterpriseController < ApplicationController
  before_action :load_enterprise

  def edit

  end

  def update

  end

  private

  def enterprise_params
    
  end

  def load_enterprise
    @enterprise = current_user&.enterprise
  end
end
