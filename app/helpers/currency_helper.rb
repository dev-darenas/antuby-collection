module CurrencyHelper
  ## TODO: this method is in base presente
  # we Need test if that method can be delete
  def currency(value)
    number_to_currency(value, separator: ".", delimiter: ".", precision: 0)
  end
end
