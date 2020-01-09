class ApplicationMailer < ActionMailer::Base
  default from: 'notification@antuby.co'
  layout 'mailer'

  helper ApplicationHelper
end
