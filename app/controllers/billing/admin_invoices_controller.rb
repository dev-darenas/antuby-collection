module Billing
  class AdminInvoicesController < BaseController

    def show
    end

    def index
      @admin_invoice = @enterprise.admin_invoices
    end

    private

  end
end
