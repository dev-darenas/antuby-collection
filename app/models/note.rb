class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true
  belongs_to :user

  delegate :name, to: :user, prefix: true
end
