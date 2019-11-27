module Invoices
  module Activities
    class VisitsController < BaseController

      private

      def activity_model
        ::Activities::Visit
      end
    end
  end
end
