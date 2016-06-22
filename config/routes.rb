Rails.application.routes.draw do
  root to: "users#activity"
  get 'test/new'

  resources :group_users
  patch "/editable", to: "editables#update"
  get "/backend", to: "backend#show", as: 'backend'

  resources :groups
  
  get "/categories/manage", to: "categories#manage", as: 'manage_categories'
  resources :categories, shallow: true do
    get "sub_categories/new", to: "categories#new", as: 'new_sub_category'
    resources :topics, shallow: true do
      resources :posts, shallow: true do
        resources :attachments
      end
    end
  end

  resources :users, shallow: true do
    resources :user_roles
    resources :user_groups
    resources :media
  end
  resources :roles, shallow: true do
    resources :role_permissions
  end
  resources :permissions
    
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :setting_groups, shallow: true do
    resources :settings, shallow: true
  end
  get "/settings", to: "settings#index"
end
