class City < ActiveRecord::Base
  attr_accessible :country_id, :name
  belongs_to :country
  default_scope order('cities.name ASC')
end
