module Gmail
  class Email
    require "google/apis/gmail_v1"
    require "googleauth"
    require "googleauth/stores/file_token_store"
    require "fileutils"
    require "mail"

    APPLICATION_NAME = "Antuby".freeze
    attr_accessor :service, :email, user

    def initialize(email_id)
      @email = Activities::Email.find(email_id)
      @user  = @email.created_by

      @service = Google::Apis::GmailV1::GmailService.new
      @service.client_options.application_name = APPLICATION_NAME
      @service.authorization = @user.google_refresh_token
    end

    def send
      mail = Mail.new do
        from    @user.email
        to      @email.contact_email || @email.invoice.third_email
        subject @email.title
        body    @email.description
      end

      message = Google::Apis::GmailV1::Message.new(
        raw: mail.to_s
      )

      service.send_user_message(
        "me",
        message
      )
    end
  end
end
