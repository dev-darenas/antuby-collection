class PaymentPresenter < BasePresenter

  def columns
    {
      date: 'Fecha de Pago',
      amount_currency: 'Monto'
    }
  end

  def amount_currency
    currency(amount)
  end

  def date
    payment_date.strftime(DATE_FORMAT)
  end

  def edit_link(*args)
    @view.edit_polymorphic_path([@model.invoice, @model])
  end
end
