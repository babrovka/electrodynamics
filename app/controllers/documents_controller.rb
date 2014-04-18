class DocumentsController < InheritedResources::Base
  def index 
    @documents = Document.all
  end
end
