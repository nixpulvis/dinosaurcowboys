# ApplicationMailer
# A mailer to send out information about a users application
# and it's status.
#
class ApplicationMailer < ActionMailer::Base
  default from: 'no-reply@party-shark.com'

  (Application::STATES << :created).each do |status|
    define_method("#{status}_email") do |application|
      @application = application
      @user = application.user
      subject = "Application to Party Shark - #{status.capitalize}"
      mail(to: @user.email, subject: subject)
    end
  end
end
