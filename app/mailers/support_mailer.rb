class SupportMailer < ActionMailer::Base
  default from: "from@example.com"

  def help_me(support)
    @support = support
    mail subject: "#{support.receiver} needs help with #{support.topic}", to: support.user.email
  end
end
