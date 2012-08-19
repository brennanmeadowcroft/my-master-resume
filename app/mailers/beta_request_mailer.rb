class BetaRequestMailer < ActionMailer::Base
  default from: "brennan@mymasterresume.com"

  def approve_request_email(email, code)
  	@email = email
  	@code = code

  	mail(:to => @email, :subject => "Your Invitation To My Master Resume Is Here!")
  end

end
