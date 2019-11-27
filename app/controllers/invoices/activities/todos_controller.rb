module Invoices
  module Activities
    class TodosController < BaseController

      private

      def activity_model
        ::Activities::Todo
      end
    end
  end
end
