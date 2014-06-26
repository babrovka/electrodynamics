class StaticPagesController < ApplicationController
  
  def index
    @articles = Article.limit(5)
    @event = Article.offset(5).limit(8)
    @best = Article.offset(7).limit(5)
  end
  
  def search 
  end

end
