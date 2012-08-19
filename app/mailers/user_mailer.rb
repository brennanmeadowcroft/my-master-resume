class UserMailer < ActionMailer::Base
  default from: "from@example.com"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "Password Reset"
  end

  def welcome_email(user)
    @user = user
    mail :to => user.email, :subject => "Welcome To My Master Resume"
  end

  def contact_form(params)
    @to = "brennan@mymasterresume.com"
    @from = params[:email]
    @subject = "Message From Contact Form"
    @sent_on = Time.now
    @body = params

    mail :to => @to, :subject => @subject, :from => @from
  end
end
