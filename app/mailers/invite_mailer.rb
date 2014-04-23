# coding: utf-8

class InviteMailer < ActionMailer::Base
  default from: "test@cyclonelabs.com"
  
  def send_invite(invite)
    @email = invite.email
    @token = invite.token

    mail to: invite.email, :subject => "инвайт на сайт electrodynamicsru"
  end
end
