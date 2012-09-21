Rails.application.config.middleware.use OmniAuth::Builder do
  provider :linkedin, "twcsgivs3zzd", "LaxvcuYD59XwZhxL", :scope => 'r_fullprofile'
end

LinkedIn.configure do |config|
  config.token = "twcsgivs3zzd"
  config.secret = "LaxvcuYD59XwZhxL"
end