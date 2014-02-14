class FinishSupport

  attr_accessor :support

  def initialize(support)
    self.support = support
  end

  def commence!
    support.done = true
    support.save!
  end

end
