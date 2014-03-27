class SupportsController < ApplicationController

  expose_decorated(:topic)
  expose_decorated(:support, attributes: :support_params)
  expose_decorated(:comments) { support.comments.includes(:user) }

  def create
    need_support = AskForSupport.new(current_user.object, topic, support_params)
    need_support.commence!
    redirect_to topics_path, notice: "We asked #{need_support.supporter} to help you."
  end


  def finish
    support_finish = FinishSupport.new(current_user.object, support)
    support_finish.commence!
    redirect_to root_path, notice: "Finished helping. Awesome!"
  end

  private

  def support_params
    params.fetch(:support, {}).permit(:body, :user_id)
  end
end
