Rails.application.routes.draw do
  
  resources :memberships
  root to: "users#activity"
  
  resources :role_scopes
  resources :last_accesses
  resources :contacts
  resources :group_groups
  get 'test/new'
  get "activity", to: "users#activity"

  resources :group_users
  patch "/editable", to: "editables#update"
  get "/backend", to: "backend#show", as: 'backend'

  resources :groups
  
  get "/categories/manage", to: "categories#manage", as: 'manage_categories'
  resources :categories, shallow: true do
    resources :categories
    #get "sub_categories/new", to: "categories#new", as: 'new_sub_category'
    resources :topics, shallow: true do
      resources :posts, shallow: true do
        resources :attachments
      end
    end
  end

  resources :users, shallow: true do
      resources :user_groups
    resources :media
  end
  resources :roles, shallow: true do
    resources :permissions
  end
  resources :permission_types
    
  resources :sessions, only: [:new, :create, :destroy]
  get 'signup', to: 'users#new', as: 'signup'
  get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'sessions#destroy', as: 'logout'
  
  resources :setting_groups, shallow: true do
    resources :settings, shallow: true
  end
  get "/settings", to: "settings#index"
end
