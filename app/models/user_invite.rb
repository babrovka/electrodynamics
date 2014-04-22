class UserInvite < ActiveRecord::Base
  attr_accessible :invite_id, :user_id
  
  belongs_to :user
  belongs_to :invite
end
