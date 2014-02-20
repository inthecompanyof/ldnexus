class SupportDecorator < Draper::Decorator

  decorates :support
  delegate :done?

  def title
    h.raw "#{receiver_info} asked #{user_info} for help with #{object.topic}"
  end

  def user_info
    user.info
  end

  def receiver_info
    receiver.info
  end

  def state_summary
    !done? ? "asked for help" : "received help from"
  end

  def topic_summary
    "with #{topic}"
  end

  def finish_button
    unless done?
      icon = h.content_tag(:i, "", class: 'glyphicon glyphicon-ok')
      h.link_to h.raw("#{icon} This is done!"), h.finish_support_path(object), method: :post, class: 'btn btn-success', confirm: "Are you sure you are done helping? This action will also set you as a supporter for this issue."
    end
  end

  def user
    UserDecorator.decorate(object.user)
  end

  def receiver
    UserDecorator.decorate(object.receiver)
  end

  def topic
    UserDecorator.decorate(object.topic)
  end

end

