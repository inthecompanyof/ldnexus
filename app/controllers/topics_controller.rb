class TopicsController < ApplicationController

  expose(:support)
  expose_decorated(:topics)
  expose_decorated(:topic)
  expose_decorated(:random_supporter, decorator: UserDecorator) do
    topic.users.without(current_user.object).sample
  end

  def index
  end
end
