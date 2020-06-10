class AdminNotificationMailer < ApplicationMailer

  def new_register(user, admin)
    @user = user.enterprise
    mail(
        to: admin.email,
        subject: "New registered customer to verify"
    )
  end
end