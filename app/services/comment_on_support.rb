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
    subscribers.each { |user| SupportMailer.new_comment(support, @comment, user).deliver }
  end

  private

  def subscribers
    arr = support.comments.map(&:user).uniq - [user]
    arr << support.receiver
  end
  
end
