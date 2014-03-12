class SupportMailer < ActionMailer::Base
  default from: AppConfig.from, cc: AppConfig.cc

  def help_me(support)
    @support = support
    subject = "#{support.receiver} asked #{support.user} for help with #{support.topic} - #{support_url(support)}"
    mail subject: subject, to: support.user.email, reply_to: support.receiver.email
  end

  def new_comment(support, comment, user)
    @support = support
    @comment = comment
    @user = user
    subject = "#{comment.user} added new comment on #{support.topic} - #{support_url(support)}"
    mail subject: subject, to: user.email
  end
end
