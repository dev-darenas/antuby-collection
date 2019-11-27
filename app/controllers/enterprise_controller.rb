class EnterpriseController < ApplicationController
  before_action :load_enterprise

  private

  def load_enterprise
    # TODO: we need prevent load N+1
    # enterprise elements
    @enterprise = current_user&.enterprise
  end
end
