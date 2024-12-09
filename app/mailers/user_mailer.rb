class UserMailer < ApplicationMailer
  def response_ready(email, response)
    @response = response
    mail(to: email, subject: "Tu respuesta está lista")
  end
end
