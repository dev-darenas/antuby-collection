module Reports
  class ActivitiesController < EnterpriseController
    def index
      @start_date = params[:start_date] || Date.today.beginning_of_month
      @end_date   = params[:end_date] || Date.today.end_of_month

      @activities = @enterprise
                      .activities
                      .range_dates(@start_date, @end_date)
                      .includes(:invoice, :created_by)

      @activities.where(third_id: params[:third_id]) if params[:third_id].blank?
      @activities.where(collection_advisor_id: params[:collector_advisor_id]) if params[:collector_advisor_id].blank?
    end
  end
end
