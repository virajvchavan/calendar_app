class SessionsController < ApplicationController
  def google_auth_callback
    auth = request.env['omniauth.auth']
    user, is_new_user = User.from_omniauth(auth)
    log_in(user)

    update_token(user, auth)
    if is_new_user
      user.load_calendars_with_events
      GoogleCalendarApi.new(user.reload.google_token).watch_calendars
    end

    redirect_to events_daily_path
  end

  def logout
    log_out
    redirect_to root_path
  end

  private
  def update_token(user, auth)
    token = user.tokens.find_or_initialize_by(provider: 'google')

    token.access_token = auth.credentials.token
    token.expires_at = auth.credentials.expires_at

    refresh_token = auth.credentials.refresh_token
    token.refresh_token = refresh_token if refresh_token.present?
    token.save
  end

end
