Briefly::Application.routes.draw do

  post '/sign_in' => 'sessions#create', as: 'create_session'
  delete '/sign_out' => 'sessions#destroy', as: 'destroy_session'

  resources :articles, path: '', except: [:show] do
    get 'crop', as: 'crop'
    get 'up', as: 'up'
    get 'down', as: 'down'
  end

  root to: 'articles#index', as: 'root'

end