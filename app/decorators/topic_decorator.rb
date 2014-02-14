class TopicDecorator < Draper::Decorator
  decorates :topic
  delegate :title, :id

  def users_count
    object.skills_count.to_i
  end

  def small_title
    topic.to_s.downcase
  end
end
