class ApplicationMailer < ActionMailer::Base
  default from: "ENV["mail_host"]"
  layout "mailer"
end
