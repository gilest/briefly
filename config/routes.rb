Briefly::Application.routes.draw do
  
  # get 'admin', controller: 'private', action: 'index', as: 'articles'
  # post 'admin/create', controller: 'private', action: 'create', as: 'create_article'
  # get 'admin/crop/:id', controller: 'private', action: 'crop', as: 'crop_article'
  # patch 'admin/update/:id', controller: 'private', action: 'update', as: 'update_article'
  # get 'admin/edit/:id', controller: 'private', action: 'edit', as: 'edit_article'
  # get 'admin/destroy/:id', controller: 'private', action: 'destroy', as: 'destroy_article'
  # get 'admin/up/:id', controller: 'private', action: 'up', as: 'up_article'
  # get 'admin/down/:id', controller: 'private', action: 'down', as: 'down_article'

  resources :articles, except: [:show] do
    get 'crop', as: 'crop'
    get 'up', as: 'up'
    get 'down', as: 'down'
  end
  
  root to: 'articles#index', as: 'index'
  
end
