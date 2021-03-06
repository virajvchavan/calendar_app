Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, 
  ENV['google_client_id'], 
  ENV['google_client_secret'],
  { scope: "userinfo.email, calendar",
    # prompt: "consent", access_type: "offline"
  }
end
