class AutoTask < ApplicationRecord
  belongs_to :enterprise

  enum time: { before: '-', after: '+' }
  enum type_task: %w(call email promise_payment task visit)
  enum type_activity: %w(tasks logs)

  scope :active, -> { where(active: true) }
end
