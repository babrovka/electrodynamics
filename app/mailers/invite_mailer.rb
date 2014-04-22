class InviteMailer < ActionMailer::Base
  default from: "test@cyclonelabs.com"
  
  def send_invite(invite)
    @email = invite.email
    @token = invite.token

    mail to: invite.email
  end
end
