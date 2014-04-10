Briefly::Application.routes.draw do

  constraints DomainConstraint.new(Briefly::Application.config.web_domain) do

    root to: 'articles#index', as: :root

    post '/sign_in' => 'sessions#create', as: :create_session
    delete '/sign_out' => 'sessions#destroy', as: :destroy_session

    resources :articles, path: '', except: [:show, :destroy] do
      member do
        get 'crop', as: :crop
        get 'up', as: :up
        get 'down', as: :down
        get 'archive', as: :archive
      end
      collection do
        post 'scrape', as: :scrape
      end
    end

    scope module: :api, constraints: { subdomain: /api/ } do
      namespace :v1 do
        resources :articles, only: :index
      end
    end

  end

  constraints DomainConstraint.new(Briefly::Application.config.shortener_domain) do

    get '/:shortener_string' => 'articles#show', as: :shortened_article

  end

end