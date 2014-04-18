class ArticlesController < InheritedResources::Base
  
  before_filter :all_articles, :only => [:index, :news, :by_category, :by_organizations]
  
  def index 
  end
  
  def news
    @articles = Article.all
    @mine = Article.where(:author_id => current_user.id) if user_signed_in?
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
    case true
    when params[:category].present?
      @articles = Article.where(:category_id => params[:category])
    when params[:tag].present?
      @articles = Article.includes(:tags).where(:tags => {:id => params[:tag]})
    else
      @articles = Article.all
    end
  end
  
end
