class UserNotificationMailer < ApplicationMailer

  def new_task(task)
    @task = task
    mail(
      to: task.collection_advisor_email,
      subject: 'Nueva tarea agregada'
    )
  end
end
