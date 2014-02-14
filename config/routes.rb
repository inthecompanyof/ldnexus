Help::Application.routes.draw do

  resources :skills
  resources :topics do
    resources :skills
    resources :supports
  end
  resources :users
  resources :supports do
    member do
      post :finish
    end
  end

  root :to => 'home#index'

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'

end
