class BlogsController < InheritedResources::Base
  def index 
    @articles = Article.all
    @mine = Article.where(:author_id => current_user.id) if user_signed_in?
  end
end
