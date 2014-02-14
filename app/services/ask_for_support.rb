class AskForSupport
  attr_accessor :supporter, :receiver, :topic

  def initialize receiver, topic, support_params
    self.receiver = receiver
    self.topic = topic
    self.supporter = find_supporter(support_params)
    new_support.topic = topic
    new_support.receiver = receiver
  end

  def commence!
    new_support.save!
    deliver_email
  end

  private

  def deliver_email
    email = SupportMailer.help_me(new_support)
    email.deliver
  end

  def find_supporter(params)
    User.find(params[:user_id])
  end

  def new_support
    @new_supprot ||= supporter.supports.new
  end

end
