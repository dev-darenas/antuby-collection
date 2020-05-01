class ExportController < EnterpriseController
  def create
    if @enterprise.update(enterprise_param)
      redirect_to edit_export_path(@enterprise)
    else
      redirect_to new_export_path
    end
  end

  def edit
    @required_columns = ImportData::ReadData::REQUIREDCOLUMNS
    @columns = ImportData::ReadData.new(@enterprise.id).row_head
  end

  def update    
    ImportData::ReadData.new(@enterprise.id).load_data(params[:export])

    ## ImportData::ReadData.new(@enterprise.id)
    # Aqui debo cargar los archivos
    redirect_to export_path(@enterprise)
  end

  def show
    # muestro el resultado
  end

  private

  def enterprise_param
    params.require(:enterprise)
          .permit(
            :excel
          )
  end
end
