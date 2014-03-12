class CommentsController < ApplicationController

  expose_decorated(:support){ Support.find(params[:support_id]) }

  def create
    comment = CommentOnSupport.new(current_user.object, support, params[:comment])
    comment.commence!
    redirect_to support_path(support), flash: { notice: "You contributed to this support request" }
  end

end
