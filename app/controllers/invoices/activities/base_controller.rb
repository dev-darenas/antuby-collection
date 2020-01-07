module Invoices
  module Activities
    class BaseController < EnterpriseController
      before_action :load_sale
      before_action :set_name_model
      before_action :load_activity, only: %w(edit update)

      def index
        @pagy, @activities = pagy(
                              @sale
                              .try(@name_model.pluralize)
                             )        
      end

      def new
        self.instance_variable_set(
          "@#{@name_model.singularize}",
          @sale.try(@name_model.pluralize).new
        )
      end

      def create  
        activity = @sale
                    .try(@name_model.pluralize)
                    .new(activity_params
                    .merge!(
                      third_id: @sale.third_id,
                      enterprise_id: @sale.enterprise_id,
                      created_by_id: current_user.id
                    )
                  )
        
        if activity.save
          flash[:success] = 'Actividad Creada'
          redirect_to edit_polymorphic_path([@sale, activity])
        else
          flash.now[:error] = activity.errors.details
          redirect_to new_polymorphic_path([@sale, activity])
        end
      end

      def edit; end

      def update
        activity = self.instance_variable_get("@#{@name_model.singularize}")
        if activity.update(activity_params)
          flash[:success] = 'Actividad Actualizado'
        else
          flash[:error] = activity.errors.details
        end

        redirect_to edit_polymorphic_path([@sale, activity])
      end
      
      private

      def activity_params
        params
          .require("activities_#{@name_model.singularize}")
          .permit(
            :title,
            :description,
            :status,
            :date_activity,
            :collection_advisor_id,
            :collector_id,
            :call_outcome,
            :remind,
            :remember,
            :due_date,
            :contact_id,
            :type_activity,
            contact_attributes: [
              :full_name,
              :phone,
              :cellphone,
              :email,
              :third_id
            ]
          )
      end

      def load_activity
        self.instance_variable_set(
          "@#{@name_model.singularize}",
          @sale.try(
            @name_model.pluralize
          ).find(activity_id)
        )
      end

      def set_name_model
        @name_model = activity_model
                        .name
                        .demodulize
                        .underscore
      end

      def load_sale
        @sale = @enterprise.sales.find(sale_id)
      end
  
      def activity_id
        require_id
      end

      def sale_id
        params.require(:sale_id)
      end

      def activity_model
        Activity
      end
    end
  end
end
