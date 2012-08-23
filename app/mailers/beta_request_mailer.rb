class BetaRequestMailer < ActionMailer::Base
  default from: "\"Brennan\" <brennan@mymasterresume.com>"

  def approve_request_email(email, code)
  	@email = email
  	@code = code

  	mail(:to => @email, :subject => "Your Invitation To My Master Resume Is Here!")
  end

  def welcome_email(user)
  	@email = user.email

  	mail(:to => @email, :subject => "Thanks for requesting an invite")
  end
end
