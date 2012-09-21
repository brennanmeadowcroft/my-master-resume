class AuthorizationsController < ApplicationController
	before_filter :signed_in_user, only: [:index, :edit, :update, :destroy]

  def auth
    client = LinkedIn::Client.new("twcsgivs3zzd", "twcsgivs3zzd")
    request_token = client.request_token(:oauth_callback => 
                                      "http://#{request.host_with_port}/auth/callback")
    session[:rtoken] = request_token.token
    session[:rsecret] = request_token.secret

    redirect_to client.request_token.authorize_url
  end

  def callback
    client = LinkedIn::Client.new("twcsgivs3zzd", "LaxvcuYD59XwZhxL")
    if session[:atoken].nil?
      pin = params[:oauth_verifier]
      atoken, asecret = client.authorize_from_request(session[:rtoken], session[:rsecret], pin)
      session[:atoken] = atoken
      session[:asecret] = asecret
    else
      client.authorize_from_access(session[:atoken], session[:asecret])
    end
    @profile = client.profile(:fields => %w(id))

    user = User.find(current_user.id)
    user.linkedin_atoken = atoken
    user.linkedin_secret = asecret
    user.linkedin_id = @profile.id

    if user.save!
    	respond_to do |format|
    		flash[:success] = "You have successfully connected your LinkedIn profile!"
			format.html { redirect_to(current_user) }
    	end
  	end
  end
end