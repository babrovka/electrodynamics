class Article < ActiveRecord::Base
  attr_accessible :text, :title
  
  has_many :article_tags
  has_many :tags, through: :article_tags
end
