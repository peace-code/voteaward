Voteaward::Application.routes.draw do
  #auth
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :candidates
  resources :users

  resources :promises
  resources :awards
  resources :giveups

  match 'pages/home' => 'pages#home'

  root :to => 'promises#index'
end