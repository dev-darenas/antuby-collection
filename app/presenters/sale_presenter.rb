class SalePresenter < BasePresenter

  def columns
    {
      code: 'code',
      third_name: 'Nombre',
      total_currency: 'total',
      balance_currency: 'Saldo',
      creation: 'Fecha de Creacion',
      expiration: 'Vencimiento',
      next_payment: 'Fecha de proximo pago',
      collection_status: 'Estado',
      collector_advisor_name: 'Asesor'
    }
  end

  def balance_currency
    currency(balance)
  end

  def total_currency
    currency(total)
  end

  def next_payment
    payment_date.strftime(DATE_FORMAT) if payment_date.present?
  end

  def creation
    creation_date.strftime(DATE_FORMAT)
  end

  def expiration
    @view.content_tag(
      :p,
      expiration_date.strftime(DATE_FORMAT),
      class: "text-#{overdue? ? 'danger' : '' }"
    )
  end

  def overdue?
    @model.expiration_date < Date.today.beginning_of_day
  end
end
