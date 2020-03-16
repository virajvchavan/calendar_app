# == Route Map
#
#                  Prefix Verb URI Pattern                              Controller#Action
#                    root GET  /                                        home#index
#            events_daily GET  /events/daily(.:format)                  events#daily
#         calendars_index GET  /calendars/index(.:format)               calendars#index
#         calendar_events GET  /calendars/:calendar_id/events(.:format) calendars#events
#                         GET  /auth/:provider/callback(.:format)       sessions#google_auth_callback
#            auth_failure GET  /auth/failure(.:format)                  redirect(301, /)
# google_webhook_callback POST /google_webhook_callback(.:format)       home#google_webhook_callback
#                   login GET  /login(.:format)                         redirect(301, /auth/google_oauth2)
#                  logout GET  /logout(.:format)                        sessions#logout

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'events/daily'
  get 'calendars/index'
  get 'calendars/:calendar_id/events', to: 'calendars#events', as: 'calendar_events'

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#google_auth_callback'
  get 'auth/failure', to: redirect('/')
  post '/google_webhook_callback', to: 'home#google_webhook_callback'

  get 'login', to: redirect('/auth/google_oauth2')
  get 'logout', to: 'sessions#logout'
end
