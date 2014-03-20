class Support < ActiveRecord::Base

  has_many :comments, dependent: :destroy
  belongs_to :receiver, class_name: 'User'
  belongs_to :user
  belongs_to :topic, counter_cache: true

  scope :done, -> { where(done: true) }
  scope :not_done, -> { where(done: false) }
  default_scope -> { order(created_at: :desc) }

  state_machine initial: :pending do
    event :ack do
      transition pending: :acknowledged
    end
    after_transition on: :ack, do: :send_ack_mailing

    event :finish do
      transition [:pending, :acknowledged] => :done
    end
    after_transition on: :finish, do: :send_finish_mailing
  end

  def send_ack_mailing
    # TODO: send emails here
  end

  def send_finish_mailing
    # TODO: send emails here
  end
end
