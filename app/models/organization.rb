class Organization < ActiveRecord::Base
  attr_accessible :index, :title, :establish_date, :site, :address, :employees, :about
  
  has_many :users
  has_many :employees
end
