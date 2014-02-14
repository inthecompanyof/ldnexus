class FinishSupport

  attr_accessor :support, :user

  def initialize(user, support)
    self.user = user
    self.support = support
  end

  def commence!
    reasign_user
    support.done = true
    support.save!
    update_counter
  end

  private

  def reasign_user
    support.user = user
  end

  def update_counter
    user.increment!(:supports_count)
  end

end
