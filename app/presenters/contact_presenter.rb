class ContactPresenter < BasePresenter

  def columns
    {
      full_name: 'Nombre',
      phone: 'Telefono',
      cellphone: 'Celular',
      email: 'Email'
    }
  end

  def edit_link(*args)
    @view.edit_client_contact_path(args[0], @model)
  end
end
