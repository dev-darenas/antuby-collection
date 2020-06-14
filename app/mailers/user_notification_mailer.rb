class UserNotificationMailer < ApplicationMailer

  def new_task(task)
    @task = task
    mail(
      to: task.collection_advisor_email,
      subject: 'Nueva tarea agregada'
    )
  end

  def new_note(note)
    @note = note
    mail(
      to: note.notable.collection_advisor_email,
      subject: "Nueva nota agregada en la tarea #{@note.notable_title}"
    )
  end

  def new_register(user)
    @enterprise = user.enterprise
    mail(
        to: user.email,
        subject: "Bienvenidos a antuby cobranza"
    )
  end

  def access_granted(user)
    @enterprise = user.enterprise
    mail(
        to: user.email,
        subject: "Tu cuenta ha sido verificada"
    )
  end
end
