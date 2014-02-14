class TopicsController < ApplicationController

  expose_decorated(:topics){ Topic.all }

  def index
  end
end
