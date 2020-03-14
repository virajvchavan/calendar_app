Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'home#index'

  # Routes for Google authentication
  get 'auth/:provider/callback', to: 'sessions#google_auth_callback'
  get 'auth/failure', to: redirect('/')

  get 'login', to: redirect('/auth/google_oauth2')
  get 'logout', to: 'sessions#logout'
end
