class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  attr_accessor :current_password
  attr_accessible :email, :password, :password_confirmation, :remember_me, :firstname, :lastname, :role, :nickname, :current_password
  
  ROLES = %w[moderator user]
  

  def first_name_with_last_name
      "#{firstname} #{lastname}" if firstname && lastname
  end
end
