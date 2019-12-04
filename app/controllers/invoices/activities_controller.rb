module Invoices
  class ActivitiesController < SalesController
    before_action :load_sale

    def index
      @pagy, @activities = pagy(@sale.activities.order(created_at: :desc))
    end

    private

    def load_sale
      @sale = @enterprise.sales.find(sale_id)
    end

    def sale_id
      params.require(:sale_id)
    end
  end
end
