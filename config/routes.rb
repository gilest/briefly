Briefly::Application.routes.draw do

  post '/sign_in' => 'sessions#create', as: :create_session
  delete '/sign_out' => 'sessions#destroy', as: :destroy_session

  resources :articles, path: '', except: [:show] do
    get 'crop', as: :crop
    get 'up', as: :up
    get 'down', as: :down
    collection do
      post 'scrape', as: :scrape
    end
  end

  scope module: :api, constraints: { subdomain: /api/ } do
    namespace :v1 do
      resources :articles, only: :index
    end
  end

  root to: 'articles#index', as: :root

end
