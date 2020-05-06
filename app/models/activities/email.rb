module Activities
  class Email < Activity
    # Cuando debemos enviar el email con log o con taks
    # o se debe de crear un nuevo tipo
    after_create :send_email

    private

    def send_email
      # Send Email from my email
      # Gmail::Email.new(self.id).send
      ActivityMailer.send_email(self).deliver_later if self.send_now?
    end
  end
end
