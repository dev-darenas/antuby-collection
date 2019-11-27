module Invoices
  module Activities
    class CallsController < BaseController

      private

      def activity_model
        ::Activities::Call
      end
    end
  end
end
