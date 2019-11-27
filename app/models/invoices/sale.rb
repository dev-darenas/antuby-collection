module Invoices
  class Sale < Invoice
    has_many :visits,
      foreign_key: :invoice_id,
      class_name: 'Activities::Visit'

    has_many :calls,
      foreign_key: :invoice_id,
      class_name: 'Activities::Call'

    has_many :emails,
      foreign_key: :invoice_id,
      class_name: 'Activities::Email'

    has_many :payment_promises,
      foreign_key: :invoice_id,
      class_name: 'Activities::PaymentPromise'

    has_many :todos,
      foreign_key: :invoice_id,
      class_name: 'Activities::Todo'
  end
end
