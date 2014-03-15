class Support < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :receiver, class_name: 'User'
  belongs_to :user
  belongs_to :topic, counter_cache: true

  scope :done, -> { where(done: true) }
  scope :not_done, -> { where(done: false) }
  default_scope -> { order(created_at: :desc) }

  def select_other_supporter!
    self.user = topic.users.without(user).sample
    if user.nil?
      fail OnlyHopeError, 'Sorry, but no one else is able to help. It all depends on you.'
    else
      save!
    end
  end
end

class OnlyHopeError < StandardError; end
