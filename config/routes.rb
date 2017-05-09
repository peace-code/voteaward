Rails.application.routes.draw do
  #auth
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  resources :candidates
  resources :users do
    collection { get :me }
  end

  resources :promises, :awards, :votes, shallow: true do
    member { post :like }
    resources :comments
  end
  resources :giveups
  resources :events
  resources :campaigns

  match 'home' => 'pages#home', as: 'home', via: [:get, :post]
  match 'info' => 'pages#info', as: 'info', via: [:get, :post]
  match 'discuss' => 'pages#discuss', as: 'discuss', via: [:get, :post]
  match 'banner' => 'pages#banner', as: 'banner', via: [:get, :post]
  match 'count' => 'pages#count', as: 'count', via: [:get, :post]

  namespace :y2012, path: '2012' do
    resources :promises, :awards, :votes, shallow: true do
      member { post :like }
      resources :comments
    end

    resources :events

    match 'home' => 'pages#home', via: [:get, :post]
    match 'info' => 'pages#info', via: [:get, :post]
    match 'discuss' => 'pages#discuss', via: [:get, :post]
    match 'banner' => 'pages#banner', via: [:get, :post]

    root to: 'pages#home'
  end

  root to: 'pages#home'
  # root to: 'pages#count'
end
