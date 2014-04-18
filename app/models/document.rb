class Document < ActiveRecord::Base
  attr_accessible :text, :title, :image, :file
  has_many :comments
  has_attached_file :image, :styles => { :thumb => "309x309#" }
  has_attached_file :file
  do_not_validate_attachment_file_type :file
  has_many :document_tags
  has_many :tags, through: :document_tags
end
