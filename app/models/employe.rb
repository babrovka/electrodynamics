class Employe < ActiveRecord::Base
  attr_accessible :firstname, :lastname, :organization_id, :position
end
