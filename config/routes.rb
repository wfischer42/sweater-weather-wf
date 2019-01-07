Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'favorites/create'
    end
  end
  namespace :api do
    namespace :v1 do
      get  'forecast',  to: 'forecast#show'
      get  'gifs',      to: 'gifs#show'
      post 'users',     to: 'users#create'
      post 'sessions',  to: 'sessions#create'
      post 'favorites', to: 'favorites#create'
    end
  end
end
