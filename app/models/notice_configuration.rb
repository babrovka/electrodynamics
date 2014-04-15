class NoticeConfiguration < ActiveRecord::Base
  attr_accessible :to_mailbox, :to_personal_messages, 
                  :about_new_messages, :about_my_comment_reply, :about_my_reply_comments, :about_mention_me, :about_new_subscriber
  belongs_to :user
end
