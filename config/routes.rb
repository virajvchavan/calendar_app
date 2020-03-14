# == Route Map
#
#       Prefix Verb URI Pattern                        Controller#Action
#         root GET  /                                  home#index
# events_index GET  /events/index(.:format)            events#index
#              GET  /auth/:provider/callback(.:format) sessions#google_auth_callback
# auth_failure GET  /auth/failure(.:format)            redirect(301, /)
#        login GET  /login(.:format)                   redirect(301, /auth/google_oauth2)
#       logout GET  /logout(.:format)                  sessions#logout

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'
  get 'events/index'

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#google_auth_callback'
  get 'auth/failure', to: redirect('/')

  get 'login', to: redirect('/auth/google_oauth2')
  get 'logout', to: 'sessions#logout'
end
