module Activities
  class Email < Activity

    require "google/apis/gmail_v1"
    require "googleauth"
    require "googleauth/stores/file_token_store"
    require "fileutils"
    require "mail"

    after_create :send_email
    APPLICATION_NAME = "Antuby".freeze

    def send_email  
      service = Google::Apis::GmailV1::GmailService.new
      service.client_options.application_name = APPLICATION_NAME
      service.authorization = self.created_by.google_refresh_token

      user_id = "me"

      activity = self
      mail = Mail.new do
        from    'darenas@softdreams.co'
        to      'daniel1144151@gmail.com'
        subject activity.title
        body    activity.description
      end

      message = Google::Apis::GmailV1::Message.new(
        raw: mail.to_s
      )

      service.send_user_message(
        user_id,
        message
      )
    end
  end
end
