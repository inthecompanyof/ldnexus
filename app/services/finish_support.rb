class FinishSupport

  attr_accessor :support, :user

  def initialize(user, support)
    self.user = user
    self.support = support
  end

  def commence!
    reasign_user
    finish_support
    update_counter
  end

  private

  def reasign_user
    support.user = user
  end

  def finish_support
    support.finish!
  end

  def update_counter
    user.increment!(:supports_count)
  end

end
