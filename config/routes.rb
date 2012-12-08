Voteaward::Application.routes.draw do
  #auth
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :candidates
  resources :users

  resources :promises
  resources :awards
  resources :giveups
  resources :events

  match 'home' => 'pages#home', as: 'home'
  match 'info' => 'pages#info', as: 'info'
  match 'discuss' => 'pages#discuss', as: 'discuss'

  root :to => 'promises#index'
end