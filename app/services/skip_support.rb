class SkipSupport < Struct.new(:support)

  def skip!
    candidate = next_candidate
    if candidate.nil?
      fail OnlyHopeError, 'Sorry, but no one else is able to help. It all depends on you.'
    else
      support.user = candidate
      support.save!
    end
  end

  def candidates
    support.topic.users.without support.user
  end

  private

  def next_candidate
    candidates.sample
  end
end

class OnlyHopeError < StandardError; end
