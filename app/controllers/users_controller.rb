class UsersController < ApplicationController
  def index
  end

  def show
  end
  
  def personal
    current_user.build_notice_configuration unless current_user.notice_configuration
  end
end
