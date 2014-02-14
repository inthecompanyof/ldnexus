Help::Application.routes.draw do

  resources :skills
  resources :topics do
    resources :skills
    resources :supports
  end
  resources :users

  root :to => 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

end
