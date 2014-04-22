class InviteMailer < ActionMailer::Base
  default from: "from@example.com"
  
  def send_invite(invite)
    @email = invite.email
    @token = invite.token

    mail to: invite.email
  end
end
