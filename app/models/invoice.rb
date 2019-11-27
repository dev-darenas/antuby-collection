class Invoice < ApplicationRecord
  belongs_to :enterprise
  belongs_to :third

  delegate :name, to: :third, prefix: true

  has_many :activities
  has_many :visits,
    class_name: 'Activities::Visit'
end
