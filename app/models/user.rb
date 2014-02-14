class User < ActiveRecord::Base

  has_many :skills, counter_cache: true
  has_many :topics, through: :skills

end
