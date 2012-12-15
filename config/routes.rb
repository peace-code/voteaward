Voteaward::Application.routes.draw do
  #auth
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :candidates
  resources :users

  resources :promises
  resources :awards
  resources :votes do
    member { post :like }
  end
  resources :giveups
  resources :events
  resources :campaigns

  match 'home' => 'pages#home', as: 'home'
  match 'info' => 'pages#info', as: 'info'
  match 'discuss' => 'pages#discuss', as: 'discuss'
  match 'banner' => 'pages#banner', as: 'banner'

  root :to => 'pages#home'
end