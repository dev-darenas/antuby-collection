module Invoices
  module Activities
    class EmailsController < BaseController

      private

      def activity_model
        ::Activities::Email
      end
    end
  end
end
