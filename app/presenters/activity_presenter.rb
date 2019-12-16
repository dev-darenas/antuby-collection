class ActivityPresenter < BasePresenter
  def date_task
    @view.content_tag(:p, due_date.strftime(DATE_FORMAT), class: "text-#{overdue? ? 'danger' : 'warning' }")
  end

  def pending_task?
    @model.task? && @model.pending?
  end

  def overdue
    @view.content_tag :span, 'Atrasada', class:'badge badge-danger' if overdue?
  end

  def overdue?
    pending_task? && @model.due_date < Date.today.beginning_of_day
  end
end