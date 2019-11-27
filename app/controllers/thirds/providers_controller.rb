module Thirds
  class ProvidersController < BaseController

    def index
      @clients = @enterprise.providers
    end

    private

    def third_model
      Provider
    end
  end
end
