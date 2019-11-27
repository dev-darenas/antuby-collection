module Invoices
  class ActivitiesController < SalesController
    before_action :load_sale

    def index
      @activities = @sale.activities
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
