class ClientPresenter < BasePresenter

  def columns
    {
      name: 'Nombre',
      email: 'Email',
      cellphone: 'Celular'
    }
  end
end
