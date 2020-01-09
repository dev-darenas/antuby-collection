class Activity < ApplicationRecord
  include Notable

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

  belongs_to :created_by,
             foreign_key: :created_by_id,
             class_name: 'User',
             optional: true

  belongs_to :contact, optional: true
  accepts_nested_attributes_for :contact

  delegate :name, :email, to: :collection_advisor, prefix: true
  delegate :name, to: :collector, prefix: true
  delegate :code, to: :invoice, prefix: true
  delegate :third_name, to: :invoice, prefix: true
  delegate :name, to: :created_by, prefix: true, allow_nil: true
  delegate :email, to: :contact, prefix: true, allow_nil: true

  scope :tasks, -> { pending.task }
  scope :today, -> {
    tasks
    .where('due_date <= ?', Date.today.end_of_day)
    .order(due_date: :asc)
  }

  after_create :send_notification, if: :task?

  private

  def send_notification
    UserNotificationMailer.new_task(self).deliver_later
  end
end
