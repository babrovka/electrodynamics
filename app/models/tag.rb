class Tag < ActiveRecord::Base
  attr_accessible :title
  
  has_many :article_tags
  has_many :articles, through: :article_tags
  has_many :document_tags
  has_many :articles, through: :document_tags
end
