module Products
  class BaseController < EnterpriseController
    before_action :load_product

    private

    def load_product
      @product = @enterprise.products.find(product_id)
    end

    def product_id
      params.require(:product_id)
    end
  end
end
