class TaskPresenter < BasePresenter

  def columns
    {
      invoice_code: 'Codigo',
      description: 'Description',
      created: 'Fecha de Creacion',
      date_task: 'Fecha de la Tarea',
    }
  end

  def edit_link(*args)
    @view.edit_polymorphic_path([@model.invoice, @model])
  end

  def date_task
    @model.remember.strftime("%d/%m/%Y %H:%M")
  end
end
