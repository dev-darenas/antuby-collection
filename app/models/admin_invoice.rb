class AdminInvoice < ApplicationRecord
  belongs_to :enterprise
  enum status: %w(pending payment)

end
