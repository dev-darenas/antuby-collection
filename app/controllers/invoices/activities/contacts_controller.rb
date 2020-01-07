module Invoices
  module Activities
    class ContactsController < BaseController
      def new
        @activity = @sale.activities.new(contact_attributes: {})
      end
    end
  end
end
