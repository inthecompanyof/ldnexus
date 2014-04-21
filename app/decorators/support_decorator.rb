class SupportDecorator < Draper::Decorator

  decorates :support
  delegate :done?, :body, :discussed?

  def title
    h.raw "#{receiver_info.titleize} asked #{user_info.titleize} for help."
  end

  def user_info
    user.to_s
  end

  def receiver_info
    receiver.to_s
  end

  def ticket_id
    "##{object.id}"
  end

  def when_started?
    "#{h.time_ago_in_words(object.created_at)} ago"
  end

  def when_finished?
    "#{h.time_ago_in_words(object.updated_at)} ago"
  end

  def action_button
    return if done? || support.receiver == h.current_user

    if discussed?
      finish_button
    else
      ack_button
    end
  end

  def skip_button
    return if done? || support.user != h.current_user

    h.link_to h.raw('Skip'), h.skip_support_path(object),
              method: :post,
              confirm: "Do you really don't have time for this one?"
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
    h.link_to h.raw('Mark as resolved'), h.finish_support_path(object),
      method: :post, class: 'btn btn-success',
      confirm: 'Are you sure you are done helping? This action will also set you as a supporter for this issue.'
  end

  def ack_button
    h.link_to h.raw('Acknowledge!'), h.ack_support_path(object),
      method: :post, class: 'btn btn-success'
  end
end
