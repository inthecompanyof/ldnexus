class SupportDecorator < Draper::Decorator

  decorates :support
  delegate :done?, :body, :discussed?

  def title
    h.raw "#{receiver} asked #{user} for help."
  end

  def ticket_id
    "##{object.id}"
  end

  def formatted_date date
    "#{h.time_ago_in_words(date)} ago"
  end

  def started_at
    formatted_date object.created_at
  end

  def finished_at
    formatted_date object.updated_at
  end

  def comments_label
    if object.discussed?
      " &middot; #{h.pluralize(object.comments_count, 'comment')}".html_safe
    end
  end

  def formatted_list_label params
    subject = h.content_tag(:strong, params[:subject])
    passive = h.content_tag(:strong, params[:passive])
    "#{subject} #{params[:action]} #{passive} in".html_safe
  end

  def folks_label
    if done?
      params = { subject: user, action: 'helped', passive: receiver }
    else
      params = { subject: receiver, action: 'asked', passive: user }
    end
    formatted_list_label params
  end

  def css_class
    done? ? 'done' : 'new'
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
