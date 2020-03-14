class SessionsController < ApplicationController

  def google_auth_callback
    auth = request.env["omniauth.auth"]
    user = User.from_omniauth(auth)
    log_in(user)
    token = user.tokens.find_or_initialize_by(provider: 'google')

    token.access_token = auth.credentials.token
    token.expires_at = auth.credentials.expires_at

    # refresh_token is sent only once during the first request
    refresh_token = auth.credentials.refresh_token
    token.refresh_token = refresh_token if refresh_token.present?

    # todo: call the api, and save data to db & then redirect

    token.save
    redirect_to root_path
  end

  def logout
    log_out
    redirect_to root_path
  end
end
