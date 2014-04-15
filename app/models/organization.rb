class Organization < ActiveRecord::Base
  attr_accessible :index, :title
  has_many :users
end
