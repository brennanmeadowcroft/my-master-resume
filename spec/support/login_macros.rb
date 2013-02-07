module LoginMacros
	# Login the user so they are the current user
	def set_user_session(user)
		session[:user_id] = user.id
		cookies.permanent[:remember_token] = user.remember_token
	end
end