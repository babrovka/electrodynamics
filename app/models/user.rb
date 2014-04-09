class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :role, :nickname
  
  ROLES = %w[moderator user]
  

  def first_name_with_last_name
      "#{firstname} #{lastname}" if firstname && lastname
  end
end
