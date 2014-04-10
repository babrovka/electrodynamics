class OrganizationsController < InheritedResources::Base
  before_filter :authenticate_user!, only: [:new, :create, :edit]
  
  def show
    @organization = Organization.find(params[:id])
    @articles = Article.all
  end
end
