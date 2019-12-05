module Thirds
  module Clients
    class InvoicesController < BaseController
      def index
        @pagy, @invoices = pagy(@client.invoices)
      end
    end
  end
end
