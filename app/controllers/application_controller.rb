class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  include Pagy::Backend

  private

  def require_id
    params.require(:id)
  end
end
