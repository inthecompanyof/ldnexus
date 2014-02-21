class SupportMailer < ActionMailer::Base
  default from: AppConfig.from, cc: AppConfig.cc

  def help_me(support)
    @support = support
    subject = "#{support.receiver} asked #{support.user} for help with #{support.topic} - #{support_url(support)}"
    mail subject: subject, to: support.user.email, reply_to: support.receiver.email
  end
end
