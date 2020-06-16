module Invoices
  class BaseController < EnterpriseController
    before_action :set_name_model
    before_action :load_invoice, only: %w(edit update)

    def index
      # TODO: Add filter to show all invoices
      if current_user.has_role? :admin
        @pagy, @sales = pagy(@enterprise.try(
                              @name_model
                            ).includes(:third)
                            .active
                        )
      else
        @pagy, @sales = pagy(
                            @enterprise.try(
                              @name_model
                            )
                            .collector(current_user.id)
                            .includes(:third)
                            .active
                        )
      end
    end

    def new
      self.instance_variable_set(
        "@#{@name_model.singularize}",
        @enterprise.try(@name_model).new(
          params[:invoices_sale].present? ? invoices_params : {}
        )
      )
    end

    def create
      self.instance_variable_set(
        "@#{@name_model.singularize}",
        @enterprise.try(@name_model).new(invoices_params)
      )

      invoice = self.instance_variable_get("@#{@name_model.singularize}")
      invoice.collector_advisor = current_user if invoice.collector_advisor.nil?

      if invoice.save
        flash[:success] = 'Factura Creada'
        # TODO: :invoices_sale should be dinamic
        redirect_to polymorphic_url(
                      :invoices_sale,
                      action: :edit,
                      id: invoice.id
                    )
      else
        flash.now[:error] = invoice.errors.details
        render :new
      end
    end

    def edit
    end

    def update
      invoice = self.instance_variable_get("@#{@name_model.singularize}")
      if invoice.update(invoices_params)
        flash[:success] = 'Factura Actualizada'
      else
        flash[:error] = invoice.errors.details
      end

      # TODO: :invoices_sale should be dinamic
      redirect_to polymorphic_url(
                    :invoices_sale,
                    action: :edit,
                    id: invoice.id
                  )
    end

    private

    def invoices_params
      # TODO: make invoices_sale global
      params
        .require(:invoices_sale)
        .permit(
          :third_id,
          :code,
          :creation_date,
          :expiration_date,
          :description,
          :total,
          :collector_advisor_id,
          :collector_id,
          :collection_status,
          third_attributes: [
            :identification,
            :enterprise_id,
            :type,
            :name,
            :email,
            :cellphone,
            :phone,
            :address_description
          ] 
        )
    end

    def load_invoice
      self.instance_variable_set(
        "@#{@name_model.singularize}",
        @enterprise.try(
          @name_model.pluralize
        ).find(invoice_id)
      )
    end

    def set_name_model
      @name_model = invoice_model
                      .name
                      .demodulize
                      .pluralize
                      .underscore
    end

    def invoice_id
      require_id
    end
  end
end
