class ArticlesController < InheritedResources::Base
  
  def show 
    @article = Article.find(params[:id])
    @comment = Comment.new
  end
  
end
