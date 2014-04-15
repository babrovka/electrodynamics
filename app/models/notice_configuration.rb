class NoticeConfiguration < ActiveRecord::Base
  attr_accessible :to_mailbox
  belongs_to :user
end
