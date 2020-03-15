class SessionsController < ApplicationController

  def google_auth_callback
    auth = request.env["omniauth.auth"]
    user, is_new_user = User.from_omniauth(auth)
    log_in(user)
    token = user.tokens.find_or_initialize_by(provider: 'google')

    token.access_token = auth.credentials.token
    token.expires_at = auth.credentials.expires_at

    refresh_token = auth.credentials.refresh_token
    token.refresh_token = refresh_token if refresh_token.present?
    token.save

    user.load_calendars if is_new_user

    redirect_to events_daily_path
  end

  def logout
    log_out
    redirect_to root_path
  end

end
