class Activity < ApplicationRecord
  belongs_to :invoice
  enum status: %w(pending cancel succes)
  enum type_activity: %w(task log)

  belongs_to :collection_advisor,
              foreign_key: :collection_advisor_id,
              class_name: 'User'

  belongs_to :collector,
             foreign_key: :collector_id,
             class_name: 'User',
             optional: true

  delegate :name, to: :collection_advisor, prefix: true
  delegate :name, to: :collector, prefix: true
  delegate :code, to: :invoice, prefix: true
end
