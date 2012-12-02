Voteaward::Application.routes.draw do
  #auth
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :users

  root :to => 'pages#home'
end