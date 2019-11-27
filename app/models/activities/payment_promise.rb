module Activities
  class PaymentPromise < Activity
    has_one :sale,
      foreign_key: :invoice_id,
      class_name: 'Invoices::Sale'
  end
end
