class ArticlesController < InheritedResources::Base
  
  def index 
    case true
    when params[:category].present?
      @articles = Article.where(:category_id => params[:category])
    when params[:tag].present?
      @articles = Article.includes(:tags).where(:tags => {:id => params[:tag]})
    else
      @articles = Article.all
    end
  end
  
  def show 
    @article = Article.find(params[:id])
    @comment = Comment.new
    @articles = Article.includes(:tags).where(:tags => {:id => @article.tags})
  end
  
  
end
