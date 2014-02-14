class Support < ActiveRecord::Base
  belongs_to :receiver, class_name: 'User'
  belongs_to :user
  belongs_to :topic
end
