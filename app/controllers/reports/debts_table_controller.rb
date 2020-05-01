module Reports
  class DebtsTableController < EnterpriseController
    
    def index
      @start_date = params[:start_date] || Date.today.beginning_of_month
      @end_date   = params[:end_date] || Date.today.end_of_month

      @invoices = @enterprise
                    .invoices
                    .active
                    .includes(:third, :activities)
                    .where(payment_date: @start_date..@end_date)
    end
  end
end
