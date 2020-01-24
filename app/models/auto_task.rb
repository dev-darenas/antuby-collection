class AutoTask < ApplicationRecord
  belongs_to :enterprise

  enum time: %w(before after)
  enum type_task: %w(call email promise_payment task visit)
  enum type_activity: %w(tasks logs)
end
