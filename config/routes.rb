Briefly::Application.routes.draw do

  constraints DomainConstraint.new(Briefly::Application.config.web_domain) do

    root to: 'articles#index', as: :root

    post '/sign_in' => 'sessions#create', as: :create_session
    delete '/sign_out' => 'sessions#destroy', as: :destroy_session

    resources :articles, path: '', except: [:show, :destroy] do
      member do
        get :crop
        get :up
        get :down
        get :archive
      end
      collection do
        post :scrape
        get :publish
      end
    end

  end

  constraints DomainConstraint.new(Briefly::Application.config.api_domain) do

    scope module: :api do
      namespace :v1 do
        resources :articles, only: :index
      end
    end

  end

  constraints DomainConstraint.new(Briefly::Application.config.shortener_domain) do

    get '/:shortener_string' => 'articles#show', as: :shortened_article

  end

end