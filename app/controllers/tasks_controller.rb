class TasksController < EnterpriseController
  def index
    @pagy, @tasks = pagy(current_user.activities
                            .includes(
                              invoice: [:third]
                            )
                            .tasks
                            .today
                        )
  end
end
