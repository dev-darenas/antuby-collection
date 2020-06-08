class ActivityPresenter < BasePresenter
  def date_task
    @view.content_tag(
            :p,
            due_date.strftime(DATE_FORMAT),
            class: "text-#{overdue? ? 'danger' : 'warning' }"
          ) if @model.due_date
  end

  def pending_task?
    @model.task? && @model.pending?
  end

  def overdue
    @view.content_tag :span, 'Atrasada', class:'badge badge-danger' if overdue?
  end

  def overdue?
    pending_task? && @model.due_date && @model.due_date < Date.today.beginning_of_day
  end

  def date_activity_format
    @model.date_activity.strftime(DATE_FORMAT)
  end

  # TODO: found a best way to get translate
  def type_tr
    case @model.type
    when 'Activities::Visit'
      'Visita'
    when 'Activities::Todo'
      'Para hacer'
    when 'Activities::Call'
      'Llamada'
    when 'Activities::Email'
      'Email'
    when 'Activities::PaymentPromise'
      'Promesa de pago'
    else
      ''
    end
  end
end
