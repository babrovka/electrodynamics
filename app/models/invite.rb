class Invite < ActiveRecord::Base
  attr_accessible :email, :token
  
  has_many :user_invites
  has_many :users, through: :user_invites
end
