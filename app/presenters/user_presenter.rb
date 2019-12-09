class UserPresenter < BasePresenter
  
  def columns
    {
      name: 'Nombre',
      role: 'Rol'
    }
  end

  def role
    roles.first.name_es
  end

  def name
    "#{first_name} #{last_name}"
  end
end
