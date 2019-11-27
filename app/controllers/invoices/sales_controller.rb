module Invoices
  class SalesController < BaseController
    
    private

    def invoice_model
      Invoices::Sale
    end
  end
end
