Briefly::Application.routes.draw do

  resources :articles, path: '', except: [:show] do
    get 'crop', as: 'crop'
    get 'up', as: 'up'
    get 'down', as: 'down'
  end

  get '/sign_in' => 'sessions#new', as: 'new_session'
  post '/sign_in' => 'sessions#create', as: 'create_session'
  delete '/sign_out' => 'sessions#destroy', as: 'destroy_session'

  root to: 'articles#index', as: 'root'

end