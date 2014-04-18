class DocumentsController < InheritedResources::Base
  def index 
    @documents = Document.all
  end
  
  def show 
    @document = Document.find(params[:id])
    @comment = Comment.new
    @articles = Article.limit(10)
  end
  
end
