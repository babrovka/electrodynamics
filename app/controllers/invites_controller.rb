class InvitesController < ApplicationController
  
  def create
    @invite = Invite.create(:params[:invite])
    @invite.save
  end

end
