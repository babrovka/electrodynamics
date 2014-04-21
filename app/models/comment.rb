class Comment < ActiveRecord::Base
  attr_accessible :article_id, :comment, :author_id, :document_id
  
  belongs_to :author, class_name: 'User'
  belongs_to :article
  belongs_to :document
end
