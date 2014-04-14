class Country < ActiveRecord::Base
  attr_accessible :name
  has_many :cities
  default_scope order('name ASC')
end
