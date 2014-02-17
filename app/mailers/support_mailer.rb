class SupportMailer < ActionMailer::Base
  default from: AppConfig.postmark.from

  def help_me(support)
    @support = support
    mail subject: "#{support.receiver} needs help with #{support.topic}", to: support.user.email
  end
end
