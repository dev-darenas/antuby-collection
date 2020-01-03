module Activities
  class Email < Activity
    # Cuando debemos enviar el email con log o con taks
    # o se debe de crear un nuevo tipo
    # after_create :send_email

    private

    def send_email
      begin
        Gmail::Email.new(self.id).send
      rescue Exception => e
        P " e "
        errors.add(:base, "Error al enviar el email!")
      end
    end
  end
end
