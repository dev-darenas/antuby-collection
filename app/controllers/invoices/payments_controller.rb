module Invoices
  class PaymentsController < EnterpriseController
    before_action :load_sale
    before_action :load_payment, only: %w(edit update)

    def index
      @pagy, @payments = pagy(@sale.payments.order(created_at: :desc))
    end

    def new
      @payment = @sale.payments.new
    end

    def create
      @payment = @sale.payments.new(payment_params)
      if @payment.save
        flash[:success] = 'Pago creado'
        redirect_to edit_invoices_sale_payment_path(@sale, @payment)
      else
        p " @payment.errors.details "
        p @payment.errors.details

        flash.now[:error] = @payment.errors.details
        render :new
      end
    end

    def edit; end

    def update
      if @payment.update(payment_params)
        flash[:success] = 'Pago editado'
      else
        flash[:error] = @payment.errors.details
      end
  
      redirect_to edit_invoices_sale_payment_path(@sale, @payment)
    end

    private

    def payment_params
      params.require(:payment)
        .permit(
          :payment_date,
          :next_payment,
          :amount,
          :reported_by_id
        )
    end

    def load_sale
      @sale = @enterprise.sales.find(sale_id)
    end

    def sale_id
      params.require(:sale_id)
    end

    def load_payment
      @payment = @sale.payments.find(require_id)
    end
  end
end
