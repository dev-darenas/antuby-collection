class OptionTypesController < EnterpriseController
  before_action :load_option_type, only: %w(edit update)

  def index
    @option_types = @enterprise.option_types
  end

  def new
    @option_type = @enterprise.option_types.new
  end

  def create
    @option_type = @enterprise.option_types.new(option_type_params)
    if @option_type.save
      flash[:success] = 'Tipo creado'
      redirect_to edit_option_type_path(@option_type)
    else
      flash.now[:error] = @option_type.errors.details
      render :new
    end
  end

  def edit
    @option_type.option_values.new
  end

  def update
    @option_type.update(option_type_params)

    if @option_type.save
      flash[:success] = 'Tipo actualizado'
    else
      flash[:error] = @option_type.errors.details
    end
    redirect_to edit_option_type_path(@option_type)
  end

  private

  def option_type_params
    params
      .require(:option_type)
      .permit(
        :name,
        option_values_attributes: [
          :id,
          :name,
          :_destroy
        ]
      )
  end

  def load_option_type
    @option_type = @enterprise.option_types.find(require_id)
  end
end
