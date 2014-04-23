class InvitesController < ApplicationController
  
  def create
    @invite = Invite.new(params[:invite])
    @invite.token = Digest::SHA1.hexdigest([Time.now, rand].join)
    if @invite.save
      current_user.invites << @invite
      InviteMailer.send_invite(@invite).deliver
      redirect_to :back, :notice => t("invite_sent")
    else 
      redirect_to :back, :alert => t("invite_already_sent_for_this_email")
    end
  end

end
