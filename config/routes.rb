Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'users/registrations' }
  get "/users/:user_id/projects", to: "users#project_index", as: "user_projects"
  get "/users/:user_id/tasks", to: "users#task_index", as: "user_tasks"
  get "/users/:user_id/available_tasks", to: "users#available_tasks", as: "user_available_tasks"

  resources :projects do
    resource :team, :only => [:show] do
      get "/add_member", to: "teams#add_member", as: "add_member"
      put "/create", to: "teams#create", as: "create"
      get "/members/:member_id/promote", to: "teams#promote_member", as: "promote_member"
      get "/members/:member_id/demote", to: "teams#demote_member", as: "demote_member"
      get "/members/:member_id/remove", to: "teams#remove_member", as: "remove_member"
    end
    resources :tasks do
      member do
        get :claim
        get :unclaim
      end
    end
    resources :bugs
    resources :asset_directory
  end

  authenticated :user do
    root 'projects#index', as: :authenticated_root
  end
  devise_scope :user do
    root 'devise/sessions#new'
  end
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
