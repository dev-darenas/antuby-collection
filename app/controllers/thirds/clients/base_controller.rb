module Thirds
  module Clients
    class BaseController < EnterpriseController
      before_action :load_client

      private

      def load_client
        @client = @enterprise.clients.find(client_id)
      end

      def client_id
        params.require(:client_id)
      end
    end
  end
end
