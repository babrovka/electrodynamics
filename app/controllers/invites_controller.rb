class InvitesController < ApplicationController
  
  def create
    @invite = Invite.new(params[:invite])
    @invite.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    @invite.save
    InviteMailer.send_invite(@invite).deliver
    redirect_to :back, :notice => t("invite_sent")
  end

end
