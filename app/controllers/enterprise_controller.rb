class EnterpriseController < ApplicationController
  before_action :load_enterprise

  def edit; end

  def update
    if @enterprise.update(enterprise_params)
      flash[:success] = 'Empresa Actualizada'
    else
      flash[:error] = @enterprise.errors.details
    end

    redirect_to edit_enterprise_path(@enterprise)
  end

  private

  def enterprise_params
    params.require(:enterprise)
      .permit(
        :name,
        :payment_conditions
      )
  end

  def load_enterprise
    @enterprise = current_user&.enterprise
  end
end
