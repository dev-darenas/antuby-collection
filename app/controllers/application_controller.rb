class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  private

  def require_id
    params.require(:id)
  end
end
