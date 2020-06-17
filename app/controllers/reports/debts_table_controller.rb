module Reports
  class DebtsTableController < EnterpriseController

    def index
      @start_date = params[:start_date] || Date.today.beginning_of_month
      @end_date   = params[:end_date] || Date.today.end_of_month
      @collector_id = params[:collector_advisor_id]

      @invoices = @enterprise
                    .invoices
                    .active
                    .includes(:third, :activities)
                    .where(payment_date: @start_date..@end_date)

      @invoices = @invoices.where(collector_advisor_id: @collector_id ) if @collector_id.present?
    end
  end
end
