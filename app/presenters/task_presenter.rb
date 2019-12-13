class TaskPresenter < ActivityPresenter

  def columns
    {
      invoice_code: 'Factura',
      invoice_third_name: 'Cliente',
      title: 'Titulo',
      description: 'Descripción',
      created: 'Fecha de Creación',
      date_task: 'Fecha de la Tarea',
    }
  end

  def edit_link(*args)
    @view.edit_polymorphic_path([@model.invoice, @model])
  end
end
