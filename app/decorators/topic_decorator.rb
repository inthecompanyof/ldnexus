class TopicDecorator < Draper::Decorator
  decorates :topic
  delegate :title, :id

  def users_count
    object.skills_count.to_i
  end

  def small_title
    topic.to_s.downcase
  end

  def supporters
    h.raw topic.users.map{|user| h.link_to(user, user) }.join(", ")
  end

  def show_link
    users_count > 0 ? self : "#"
  end

  def show_link_text
    if users_count > 0
      "#{topic} - #{topic.users_count} people can help"
    else
      "#{topic} - Sorry, no one is available to help yet"
    end
  end
end
