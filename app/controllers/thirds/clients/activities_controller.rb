module Thirds
  module Clients
    class ActivitiesController < BaseController
      def index
        if params[:task].present?
          @pagy, @activities = pagy(
                                @client.activities
                                       .includes(
                                        :invoice,
                                        :collection_advisor,
                                        :collector
                                       )
                                       .today
                               )
        else
          @pagy, @activities = pagy(
                                @client.activities
                                       .includes(
                                         :invoice,
                                         :collection_advisor,
                                         :collector
                                        )
                                       .order(date_activity: :desc)
                               )
        end
      end
    end
  end
end
