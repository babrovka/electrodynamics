class DocumentTag < ActiveRecord::Base
  attr_accessible :document_id, :tag_id
  
  belongs_to :document
  belongs_to :tag
end
