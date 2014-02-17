class AskForSupport

  attr_accessor :supporter_id, :receiver, :topic

  def initialize receiver, topic, support_params
    self.receiver = receiver
    self.topic = topic
    self.supporter_id = support_params[:user_id]
  end

  def commence!
    setup_support
    new_support.save!
    deliver_email
  end

  def setup_support

    new_support.user = supporter
    new_support.topic = topic
    new_support.receiver = receiver

  end

  def new_support
    @new_supprot ||= Support.new
  end

  def supporter
    @supporter ||= User.find(supporter_id)
  end

  private

  def deliver_email
    email = SupportMailer.help_me(new_support)
    email.deliver
  end



end
