class UserDecorator < Draper::Decorator
  decorates :user

  delegate :to_s, :email

  def topic_class(topic)
    object.helps_with?(topic.object) ? "btn-success" : "btn-danger"
  end

  def help_summary(topic)
    object.helps_with?(topic.object) ? "you can help with that!" : "you are not helping yet."
  end

end
