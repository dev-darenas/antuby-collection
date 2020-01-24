class AutoTaskPresenter < BasePresenter
  def columns
    {
      name: 'Nombre',
      type_task: 'Tipo de Tarea'
    }
  end
end
