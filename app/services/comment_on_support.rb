class CommentOnSupport

  attr_accessor :user, :support, :comment_params

  def initialize(user, support, comment_params)
    self.user = user
    self.support = support
    self.comment_params = comment_params
  end

  def commence!
    new_comment.save!
    deliver_email
  end

  def new_comment
    @comment ||= Comment.new(user: user,
                             support: support,
                             body: comment_params[:body])
  end

  def deliver_email
    subscribers.each { |user| send_email_to_user(user).deliver }
  end

  private

  def send_email_to_user(user)
    SupportMailer.new_comment(support, new_comment, user)
  end

  def subscribers
    ids = support.comments.pluck(:user_id).uniq - [user.id] + [support.receiver_id]
    User.where id: ids
  end
end
