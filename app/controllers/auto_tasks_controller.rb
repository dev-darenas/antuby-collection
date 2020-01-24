class AutoTasksController < EnterpriseController
  before_action :load_auto_task, only: %w(edit update)

  def index
    @pagy, @auto_tasks = pagy(@enterprise.auto_tasks)
  end

  def new
    @auto_task = @enterprise.auto_tasks.new
  end

  def create
    @auto_task = @enterprise.auto_tasks.new(auto_task_params)

    if @auto_task.save
      flash[:success] = 'Tarea creado'
      redirect_to edit_auto_task_path(@auto_task)
    else
      flash.now[:error] = @auto_task.errors.details
      render :new
    end
  end

  def edit; end

  def update
    if @auto_task.update(auto_task_params)
      flash[:success] = 'Tarea editada'
    else
      flash[:error] = @auto_task.errors.details
    end

    redirect_to edit_auto_task_path(@auto_task)
  end

  private

  def auto_task_params
    params.require(:auto_task)
      .permit(
        :name,
        :time,
        :number_days,
        :type_task,
        :type_activity,
        :title,
        :description
      )
  end

  def load_auto_task
    @auto_task = @enterprise.auto_tasks.find(require_id)
  end
end
