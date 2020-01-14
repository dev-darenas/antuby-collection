class Note < ApplicationRecord
  belongs_to :notable, polymorphic: true
  belongs_to :user

  delegate :name, to: :user, prefix: true
  delegate :title, to: :notable, prefix: true

  after_create :send_notification

  private

  def send_notification
    ## solo enviar notas a las actividades
    UserNotificationMailer.new_note(self).deliver_later
  end
end
