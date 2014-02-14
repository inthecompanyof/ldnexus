#registers users skill in given topic
class SkillRegistraion

  attr_accessor :user, :topic

  def initialize(user, topic)
    self.user = user
    self.topic = topic
  end

  def toggle!
    if user.helps_with?(topic)
      destroy_skill
    else
      create_skill
    end
  end

  private

  def destroy_skill
    skill = user.skills.find_by(topic_id: topic.id)
    skill.destroy
  end

  def create_skill
    user.skills.create(topic_id: topic.id)
  end

end
