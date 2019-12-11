class SalePresenter < BasePresenter

  def columns
    {
      code: 'code',
      third_name: 'Nombre',
      total: 'total',
      balance: 'balance',
      expiration: 'Fecha de pago'
    }
  end

  def expiration
    expiration_date.strftime(DATE_FORMAT)
  end
end
