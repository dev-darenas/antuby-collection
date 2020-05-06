class AutoTaskPresenter < BasePresenter
  def columns
    {
      name: 'Nombre',
      type_task: 'Tipo de Tarea',
      active: 'Activado'
    }
  end
end
