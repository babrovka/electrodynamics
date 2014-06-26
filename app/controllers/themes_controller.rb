class ThemesController < ApplicationController
  
  def show
    @organizations = Organization.all
    @articles = Article.all
  end

end
