class TasksController < EnterpriseController
  def index
    @tasks = current_user.activities
  end
end
