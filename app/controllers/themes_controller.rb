class ThemesController < ApplicationController
  
  def show
    @organizations = Organization.all
    @articles = Article.all
    @theme = Theme.find(params[:id])
  end

end
