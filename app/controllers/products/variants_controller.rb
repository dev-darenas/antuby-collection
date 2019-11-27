module Products
  class VariantsController < BaseController
    before_action :load_variant, only: %w(edit update)

    def index
      @variants = @product.variants
    end

    def new
      @variant = @product.variants.new
    end

    def create
      @variant = @product.variants.new(variant_params)
      if @variant.save
        flash[:success] = 'Producto creado'
        redirect_to edit_product_variant_path(@product, @variant)
      else
        flash.now[:error] = @variant.errors.details
        render :new
      end
    end

    def edit; end

    def update
      if @variant.update(variant_params)
        flash[:success] = 'Variante editado'
      else
        flash[:error] = @variant.errors.details
      end

      redirect_to edit_product_variant_path(@product, @variant)
    end

    private

    def variant_params
      params.require(:variant)
        .permit(
          :sku,
          :price,
          option_value_ids: []
        )
    end

    def load_variant
      @variant = @product.variants.find(require_id)
    end
  end
end
