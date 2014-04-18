class Country < ActiveRecord::Base
  attr_accessible :name
  has_many :cities
  scope :with_cities, includes(:cities).where("cities.country_id != 0")
  default_scope order('countries.name ASC')
end
