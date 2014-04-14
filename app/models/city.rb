class City < ActiveRecord::Base
  attr_accessible :country_id, :name
  belongs_to :country
  default_scope order('name ASC')
end
