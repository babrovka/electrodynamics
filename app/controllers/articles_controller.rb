class ArticlesController < InheritedResources::Base
  
  def index 
    @articles = params[:category] ? Article.where(:category_id => params[:category]) : Article.all
  end
  
  def show 
    @article = Article.find(params[:id])
    @comment = Comment.new
    @articles = Article.includes(:tags).where(:tags => {:id => @article.tags})
  end
  
  
end
