module Thirds
  class BaseController < EnterpriseController
    before_action :set_name_model
    before_action :load_third, only: %w(edit update)

    def index
      if current_user.has_role? :admin
        @pagy, @thirds = pagy(@enterprise.try(@name_model.pluralize))
      else
        @pagy, @thirds = pagy(current_user.try(@name_model.pluralize))
      end
    end

    def show; end
  
    def new
      self.instance_variable_set(
        "@#{@name_model}",
        @enterprise.try(@name_model.pluralize).new
      )
    end

    def create
      self.instance_variable_set(
        "@#{@name_model}",
        @enterprise.try(@name_model.pluralize).new(third_params)
      )

      third = self.instance_variable_get("@#{@name_model}")
      if third.save
        flash[:success] = 'Cliente creado'

        redirect_to polymorphic_url(
                      @name_model,
                      action: :edit,
                      id: third.id
                    )
      else
        flash.now[:error] = third.errors.details
        render :new
      end
    end

    def edit; end
  
    def update
      third = self.instance_variable_get("@#{@name_model}")
      if third.update(third_params)
        flash[:success] = 'Cliente actualizado'
      else
        flash[:error] = third.errors.details
      end

      redirect_to polymorphic_url(
        @name_model,
        action: :edit,
        id: third.id
      )
    end
  
    private

    def third_params
      params
        .require(third_model.name.underscore)
        .permit(
          :identification,
          :name,
          :email,
          :cellphone,
          :phone,
          :address_description
        )
    end

    def set_name_model
      @name_model = third_model.name.underscore
    end

    def load_third
      self.instance_variable_set(
        "@#{@name_model}",
        @enterprise.try(
          @name_model.pluralize
        ).find(third_id)
      )
    end

    def third_id
      require_id
    end
  end
end
