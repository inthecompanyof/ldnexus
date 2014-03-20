class SupportDecorator < Draper::Decorator

  decorates :support
  delegate :done?, :body

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

  def action_button
    return if done? || support.receiver == h.current_user

    case support.state
    when 'pending'
      ack_button
    else
      finish_button
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

  private

  def finish_button
    icon = h.content_tag(:i, nil, class: 'glyphicon glyphicon-ok')
    h.link_to h.raw("#{icon} Mark this as done!"), h.finish_support_path(object),
      method: :post, class: 'btn btn-success',
      confirm: 'Are you sure you are done helping? This action will also set you as a supporter for this issue.'
  end

  def ack_button
    icon = h.content_tag(:i, nil, class: 'glyphicon glyphicon-eye-open')
    h.link_to h.raw("#{icon} Acknowledge!"), h.ack_support_path(object),
      method: :post, class: 'btn btn-success'
  end
end

