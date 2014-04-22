class UsersController < ApplicationController
  
  before_filter :authenticate_user!, only: [:personal]
  
  def index
    @articles = Article.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def personal
    current_user.build_notice_configuration unless current_user.notice_configuration
    @invite = Invite.new
  end
end
