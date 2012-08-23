ActionMailer::Base.smtp_settings = {  
    :address => "mail.mymasterresume.com",
    :port => 25,
    :domain => "mymasteresume.com",
    :user_name => "brennan@mymasterresume.com",
    :password => "supergeo",
    :authentication => 'plain',
    :openssl_verify_mode => 'none'
  }