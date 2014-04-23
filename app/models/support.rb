class Support < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :receiver, class_name: 'User'
  belongs_to :user
  belongs_to :topic, counter_cache: true

  NEW_RANGE        = 0..1
  OK_RANGE         = 2..3
  WORRYING_RANGE   = 4..5

  scope :done, -> { where(done: true) }
  scope :not_done, -> { where(done: false) }
  default_scope -> { order(created_at: :desc) }

  def discussed?
    comments_count > 0
  end

  def status
    days = (created_at.to_date..Date.today).count
    comments_coefficient = discussed? ? 0 : 1
    score = days + comments_coefficient
    status_label_by_score(score)
  end

  def comments_count
    # TODO: replace with counter cache
    comments.count
  end

  private

  def status_label_by_score(score)
    ranges = [
      { range: NEW_RANGE, name: 'new' },
      { range: OK_RANGE, name: 'ok' },
      { range: WORRYING_RANGE, name: 'worrying' }
    ]
    ranges.each { |r| return r[:name] if r[:range].include?(score) }
    'critical'
  end
end
