class ArticlesController < InheritedResources::Base
  
  before_filter :all_articles, :only => [:new, :by_category, :by_organizations]
  
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
  
  def news
  end
  
  def by_category
  end
  
  def by_organizations
  end
  
  def show 
    @article = Article.find(params[:id])
    @comment = Comment.new
    @articles = Article.includes(:tags).where(:tags => {:id => @article.tags})
  end
  
  def all_articles
    @articles = Article.all
  end
  
end
