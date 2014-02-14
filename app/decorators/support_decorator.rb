class SupportDecorator < Draper::Decorator

  decorates :support
  delegate :user, :receiver, :topic, :done?

  def title
    "#{object.receiver} asked #{object.user} for help with #{object.topic}"
  end

end

