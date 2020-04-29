module Reports
  class DebtsController < EnterpriseController
    
    def index
      @total_receivable = @enterprise.invoices.active.sum(:balance)
      @total_expired = @enterprise.invoices.active.expired.sum(:balance)
      @total_not_expired = @enterprise.invoices.active.not_expired.sum(:balance)
      
      @data = [
        ["Vencido más de 60 días", @enterprise.invoices.active.where("payment_date < ?", Date.today - 61.days ).sum(:balance) ],
        ["Vencido 30-60 días", @enterprise.invoices.active.where(payment_date: (Date.today - 60.days)..(Date.today - 31.days)).sum(:balance) ],
        ["Vencido hace 30 días", @enterprise.invoices.active.where(payment_date: (Date.today - 30.days)..(Date.today - 1.days)).sum(:balance) ],
        ["Hoy", @enterprise.invoices.active.where(payment_date: Date.today).sum(:balance) ],
        ["vence en 30-60 días", @enterprise.invoices.active.where(payment_date: (Date.today + 1.days)..(Date.today + 30.days)).sum(:balance) ],
        ["vence en 60-90 días", @enterprise.invoices.active.where(payment_date: (Date.today + 31.days)..(Date.today + 60.days)).sum(:balance) ],
        ["vence en mas de 90 días", @enterprise.invoices.active.where("payment_date > ?", Date.today + 61.days ).sum(:balance) ]
      ]
    end
  end
end
