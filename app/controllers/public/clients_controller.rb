module Public
  class ClientsController < BaseController

    def show
      @client = Client.find(client_id)
      @enterprise = @client.enterprise
    end

    private

    def client_id
      params[:id]
    end
  end
end
