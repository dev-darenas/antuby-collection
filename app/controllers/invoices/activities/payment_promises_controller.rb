module Invoices
  module Activities
    class PaymentPromisesController < BaseController

      private

      def activity_model
        ::Activities::PaymentPromise
      end
    end
  end
end
