# ApplicationMailer
# A mailer to send out information about a users application
# and it's status.
#
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@vintage-guild.org'

  (Application.statuses.keys << 'created').each do |status|
    define_method("#{status}_email") do |application|
      @application = application
      @user = application.user
      subject = 'Application to Dinosaur Cowboys'
      mail(to: @user.email, subject: subject)
    end
  end
end
