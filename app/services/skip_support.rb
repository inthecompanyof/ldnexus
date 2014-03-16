class SkipSupport < Struct.new(:support)
  def skip!
    support.user = support.topic.users.without(support.user).sample
    if support.user.nil?
      fail OnlyHopeError, 'Sorry, but no one else is able to help. It all depends on you.'
    else
      support.save!
    end
  end
end

class OnlyHopeError < StandardError; end
