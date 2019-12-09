class UsersController < EnterpriseController
  before_action :load_user, only: %w(edit update)

  def index
    @pagy, @users = pagy(@enterprise.users)
  end

  def new
    @user = @enterprise.users.new
  end

  def create
    @user = @enterprise.users.new(user_params)
    if @user.save
      flash[:success] = 'Usuario creado'
      redirect_to edit_user_path(@user)
    else
      flash.now[:error] = @user.errors.details
      render :new
    end
  end

  def edit; end

  def update
    if params[:user][:current_password].present? &&
        current_user.valid_password?(params[:user][:current_password])
        
        unless @user.update(user_params.extract!(:password, :password_confirmation))
          flash[:error] = 'Incorrect password'
          redirect_to edit_user_path(@user)
          return
        end
    end

    if @user.update(user_params.except(:password, :password_confirmation))
      flash[:success] = 'Usuario editado'
    else
      flash[:error] = @user.errors.details
    end

    redirect_to edit_user_path(@user)
  end

  private

  def user_params
    params.require(:user)
          .permit(
            :email,
            :password,
            :password_confirmation,
            :first_name,
            :last_name,
            role_ids: []
          )
  end

  def load_user
    @user = @enterprise.users.find(require_id)
  end
end
