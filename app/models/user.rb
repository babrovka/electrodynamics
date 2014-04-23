class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :current_password, :token
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, 
                  :role, :nickname, :current_password, :country_id, :city_id, :notice_configuration_attributes, :organization_id, :token
                  
  has_one :notice_configuration
  belongs_to :organization
  accepts_nested_attributes_for :notice_configuration, allow_destroy: true
  
  has_many :user_invites
  has_many :invites, through: :user_invites
  
  validates :firstname, :lastname, :nickname, :role, :token, :presence => true
  validate :validates_token_is_correct
  
  ROLES = %w[moderator user]
  
  def validates_token_is_correct
    invite = Invite.find_by_email(self.email)
    errors.add(:token, I18n.t("token_is_incorrect")) unless
    invite.token == self.token
  end
    

  def first_name_with_last_name
      "#{firstname} #{lastname}" if firstname && lastname
  end
  
  def invite_qty
    5 - self.invites.count
  end
  
  def has_invites
    self.invites.count < 5 
  end
end
