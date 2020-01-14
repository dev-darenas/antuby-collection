module Activities
  class PaymentPromise < Activity
    after_save :update_invoice, if: :task?

    private

    def update_invoice
      self.invoice.update(
        collection_status: :paymen_promise,
        payment_date: self.due_date
      )
    end
  end
end
