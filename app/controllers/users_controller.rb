class UsersController < ApplicationController
  def index
  end

  def show
  end
  
  def personal
    @notice_configuration = NoticeConfiguration.find_or_create_by_user_id(current_user.id)
  end
end
