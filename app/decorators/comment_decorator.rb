class CommentDecorator < Draper::Decorator

  decorates :comment
  delegate :id, :body

  def user_info
    user.info
  end

  def created_at
    object.created_at.to_formatted_s(:short)
  end

  def user
    UserDecorator.decorate(object.user)
  end

end
