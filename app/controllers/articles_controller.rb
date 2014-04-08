class ArticlesController < InheritedResources::Base
  
  def show 
    @article = Article.find(params[:id])
    @comment = Comment.new
    @articles = Article.includes(:tags).where(:tags => {:id => @article.tags})
  end
  
end
