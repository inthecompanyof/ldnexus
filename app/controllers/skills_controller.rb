class SkillsController < ApplicationController

  expose_decorated(:topics)
  expose_decorated(:topic)
  expose_decorated(:skills) { current_user.skills }

  def index
  end

  def create
    skill_registration = SkillRegistration.new(current_user.object, topic)
    skill_registration.commence!
    redirect_to skills_path
  end
end
