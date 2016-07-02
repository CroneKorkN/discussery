Rails.application.routes.draw do
  
  resources :private_chats
  root to: "users#activity"
  get "activity", to: "users#activity"
  get "user_selection", to: "members#select"
  
  resources :roles
  resources :topics
  resources :memberships

  resources :group_users
  patch "/editable", to: "editables#update"
  get "/backend", to: "backend#show", as: 'backend'

  resources :groups do
    resources :roles
    resources :memberships
    resources :members
  end
  
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
  resources :posts

  resources :users, shallow: true do
    resources :media
    resources :contacts
    get "private_chat", to: "private_chats#show"
  end

  resources :role_types, shallow: true do
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
