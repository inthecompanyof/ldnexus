class TopicsController < ApplicationController

  expose_decorated(:topics){ Topic.all }
  expose_decorated(:topic){ Topic.find(params[:id]) }
  expose_decorated(:random_supporters, decorator: UserDecorator){ topic.users.shuffle }

  def index
  end
end
