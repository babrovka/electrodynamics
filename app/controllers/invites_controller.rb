class InvitesController < ApplicationController
  
  def create
    @invite = Invite.create(:params[:invite])
    @invite.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    @invite.save
  end

end
