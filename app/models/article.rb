class Article < ActiveRecord::Base
  attr_accessible :text, :title, :tag_ids
  
  has_many :article_tags
  has_many :tags, through: :article_tags
  has_many :comments
  
  belongs_to :author, class_name: 'User'
end
