class ActivityMailer < ApplicationMailer
  def send_email(email)
    @email = email
    @body  = email.description
    mail(
      to: email.invoice_third_email,
      subject: email.title
    )
  end
end
