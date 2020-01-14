module Invoices
  class ActivitiesController < EnterpriseController
    before_action :load_sale
    before_action :load_activity, only: :update

    def index
      activities = @sale
                    .activities
                    .includes(:notes)
                    .order(created_at: :desc)

      activities = activities.task.pending if params[:task].present?

      @pagy, @activities = pagy(activities)
    end

    def update
      @activity.update(activity_params)
      respond_to do |format|
        if @activity.save
          flash.now[:success] = 'Actividad Actualizada'
        else
          flash.now[:error] = @activity.errors.details
        end

        format.js { render action: :update }
      end
    end

    private

    def activity_params
      params
      .require(:activity)
      .permit(
        :status,
        :call_outcome
      )
    end

    def load_sale
      @sale = @enterprise.sales.find(sale_id)
    end

    def sale_id
      params.require(:sale_id)
    end

    def load_activity
      @activity = @sale.activities.find(require_id)
    end
  end
end
