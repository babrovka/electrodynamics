class StaticPagesController < ApplicationController
  
  def index
    @articles = Article.limit(5)
    @event = Article.offset(5).limit(8)
    @best = Article.offset(7).limit(5)
    @tags = Tag.limit(9)
  end

end
