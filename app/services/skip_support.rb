class SkipSupport < Struct.new(:support)
  require 'active_support/core_ext/string'

  attr_accessor :candidate, :success
  attr_writer :candidates

  def commence!
    self.success = false
    self.candidate = next_candidate
    if can_skip?
      support.user = candidate
      support.save!
      self.success = true
    end
    self
  end

  def success?
    success
  end

  def candidates
    @candidates ||= support.topic.users.without support.user
  end

  private

  def can_skip?
    candidate.present?
  end

  def next_candidate
    candidates.sample
  end
end

