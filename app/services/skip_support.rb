class SkipSupport < Struct.new(:support)
  require 'active_support/core_ext/string'

  attr_accessor :candidate
  attr_writer :candidates

  def skip!
    self.candidate = next_candidate
    if can_skip?
      support.user = candidate
      support.save!
    end
    self
  end

  def success?
    candidate.present?
  end
  alias_method :can_skip?, :success?

  def candidates
    @candidates ||= support.topic.users.without support.user
  end

  private

  def next_candidate
    candidates.sample
  end
end

