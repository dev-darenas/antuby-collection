class SalePresenter < BasePresenter

  def columns
    {
      code: 'code',
      third_name: 'Nombre',
      total: 'total',
      balance: 'balance',
    }
  end
end