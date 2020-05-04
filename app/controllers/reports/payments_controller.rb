module Reports
  class PaymentsController < EnterpriseController
    
    def index
      @start_date = params[:start_date] || Date.today.beginning_of_month
      @end_date   = params[:end_date] || Date.today.end_of_month

      @payments = @enterprise
                    .payments
                    .includes(:invoice)
                    .where(payment_date: @start_date..@end_date)

      @data = []
      @enterprise.users.with_role(:collection_advisor).each do |collection_advisor|
        collection_advisor_report = []
        (@start_date..@end_date).each do |date|
          collection_advisor_report.push(
            [
              date.strftime('%d/%b/%Y'),
              @enterprise
                .payments
                .includes(:invoice)
                .where(
                  payment_date: date.beginning_of_day..date.end_of_day, 
                  invoices: { collector_advisor_id: collection_advisor.id }
                )
                .sum(:amount)
            ]
          )
        end
        @data.push({ name: collection_advisor.name, data: collection_advisor_report })
      end
    end
  end
end
