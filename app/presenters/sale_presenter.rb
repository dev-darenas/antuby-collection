class SalePresenter < BasePresenter

  def columns
    {
      code: 'code',
      third_name: 'Nombre',
      total: 'total',
      balance: 'Saldo',
      expiration: 'Fecha de pago'
    }
  end

  def creation
    creation_date.strftime(DATE_FORMAT)
  end

  def expiration
    expiration_date.strftime(DATE_FORMAT)
  end
end
