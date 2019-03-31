# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'from@example.com' # TODO: Change for default email
  layout 'mailer'
end
