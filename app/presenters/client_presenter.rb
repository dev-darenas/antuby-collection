class ClientPresenter < BasePresenter

  def columns
    {
      identification: '#',
      name: 'Nombre',
      email: 'Email',
      cellphone: 'Celular',
      total_receivable: 'Deuda Total',
      total_expired: 'Total expirado',
    }
  end

  def total_invoices
    currency(@model.invoices.sum(:total))
  end

  def total_receivable
    currency(@model.invoices.sum(:balance))
  end

  def total_expired
    currency(@model.invoices.expired.sum(:balance))
  end

  def total_not_expired
    currency(@model.invoices.not_expired.sum(:balance))
  end
end
