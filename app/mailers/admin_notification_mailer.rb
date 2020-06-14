class AdminNotificationMailer < ApplicationMailer

  def new_register(user, admin)
    @enterprise = user.enterprise
    @admin=admin
    mail(
        to: admin.email,
        subject: "New registered customer to verify"
    )
  end
end
