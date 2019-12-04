class TasksController < EnterpriseController
  def index
    @pagy, @tasks = pagy(current_user.activities
                            .includes(:invoice)
                            .tasks
                            .where('remember <= ?', Date.today.end_of_day)
                            .order(remember: :desc)
                        )
  end
end
