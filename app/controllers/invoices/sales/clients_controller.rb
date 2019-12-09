module Invoices
  module Sales
    class ClientsController < EnterpriseController
      def new
        @sale = @enterprise.sales.new(third_attributes: {})
      end
    end
  end
end