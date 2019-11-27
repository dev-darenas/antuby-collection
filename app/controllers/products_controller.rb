class ProductsController < EnterpriseController
  before_action :load_product, only: %w(edit update)

  def index
    @products = @enterprise.products
  end

  def new
    @product = @enterprise.products.new
  end

  def create
    @product = @enterprise.products.new(product_params)
    if @product.save
      flash[:success] = 'Producto creado'
      redirect_to edit_product_path(@product)
    else
      flash.now[:error] = @product.errors.details
      render :new
    end
  end

  def edit
    @product.product_option_types.new
  end

  def update
    if @product.update(product_params)
      flash[:success] = 'Producto editado'
    else
      flash[:error] = @product.errors.details
    end

    redirect_to edit_product_path(@product)
  end

  private

  def product_params
    params.require(:product)
      .permit(
        :name,
        :sku,
        :price,
        :description,
        product_option_types_attributes: [
          :id,
          :option_type_id,
          :_destroy
        ]
      )
  end

  def load_product
    @product = @enterprise.products.find(require_id)
  end
end
