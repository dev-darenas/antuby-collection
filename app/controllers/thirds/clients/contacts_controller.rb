module Thirds
  module Clients
    class ContactsController < BaseController
      before_action :load_contact, only: %w(edit update)

      def index
        @pagy, @contacts = pagy(@client.contacts)
      end

      def new
        @contact = @client.contacts.new
      end

      def create
        @contact = @client.contacts.new(contact_params)
        if @contact.save
          flash[:success] = 'Contacto creado'
          redirect_to edit_client_contact_path(@client, @contact)
        else
          flash.now[:error] = @contact.errors.details
          redirect_to :new
        end
      end

      def edit; end

      def update
        if @contact.update(contact_params)
          flash[:success] = 'Contacto actualizado'
          redirect_to edit_client_contact_path(@client, @contact)
        else
          flash[:error] = @contact.errors.details
          redirect_to edit_client_contact_path(@client, @contact)
        end
      end

      private

      def contact_params
        params.require(:contact)
          .permit(
            :full_name,
            :phone,
            :cellphone,
            :email
          )
      end

      def load_contact
        @contact = @client.contacts.find(require_id)
      end
    end
  end
end
