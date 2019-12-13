module Invoices
  class ActivitiesController < EnterpriseController
    before_action :load_sale
    before_action :load_activity, only: :update

    def index
      @pagy, @activities = pagy(@sale.activities.order(created_at: :desc))
    end

    def update
      @activity.update(activity_params)
    end

    private

    def activity_params
      params
      .require(:activity)
      .permit(
        :status,
        :call_outcome
      )
    end

    def load_sale
      @sale = @enterprise.sales.find(sale_id)
    end

    def sale_id
      params.require(:sale_id)
    end

    def load_activity
      @activity = @sale.activities.find(require_id)
    end
  end
end
