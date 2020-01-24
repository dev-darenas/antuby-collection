class AdminInvoicePresenter < BasePresenter  
  def created
    @model.created_at.strftime("%d/%b/%Y")
  end

  def total_currency
    currency(total)
  end

  def payment
    @model.payment_date.strftime("%d/%b/%Y") if @model.payment_date
  end
end
