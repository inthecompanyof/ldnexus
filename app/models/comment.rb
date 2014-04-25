class Comment < ActiveRecord::Base
  belongs_to :support
  belongs_to :user
end
