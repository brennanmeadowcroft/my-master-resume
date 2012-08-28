ResumeApp::Application.routes.draw do
  resources :tags
  resources :users
  resources :resumes
  resources :sessions, :only => [:new, :create, :destroy]
  resources :static_pages
  resources :password_resets
  resources :activities
  resources :awards
  resources :education
  resources :positions
  resources :experiences, :only => [:new, :edit, :create, :update, :destroy]
  resources :skills
  resources :styles
  resources :beta_requests
  resources :beta_codes, :only => [:index, :new, :edit, :create, :update, :destroy]

  root to: 'static_pages#index'

  match '/signup', to: 'users#new'
  match '/signin', to: 'sessions#new'
  match '/signout', to: 'sessions#destroy'

  match 'users/:id/password', to: 'users#password', :as => "edit_password"
  match 'users/:id/make_admin', to: 'users#make_admin', :as => "make_admin"
  match 'users/:id/revoke_admin', to: 'users#revoke_admin', :as => "revoke_admin"

  match '/request_invite', to: 'beta_requests#new', :as => "request_invite"

  match 'password_resets/:id/admin_password_reset', to: 'password_resets#admin_password_reset', :as => "admin_password_reset"

  match 'resumes/:id/export', to: 'resumes#export', :as => "export_resume"
  match 'styles/:id/set_base_style', to: 'styles#set_base_style', :as => "set_base_style", :via => :post

  match 'experiences/mass_add', to: 'experiences#mass_add', :as => "experience_mass_add"
  match 'experiences/mass_create', to: 'experiences#mass_create', :as => "experience_mass_create", :via => :post

  match 'master_resumes/', to: 'master_resumes#index', :as => "master_resumes"
  match 'master_resumes/edit', to: 'master_resumes#edit', :as => "edit_master_resumes"
  match 'master_resumes/new', to: 'master_resumes#new', :as => "new_master_resumes"

  match '/features', to: 'static_pages#features', :as => "features"
  match '/about', to: 'static_pages#about', :as => "about"
  match '/contact', to: 'static_pages#contact', :as => "contact"
  match 'static_pages/contact_form', to: 'static_pages#contact_form'
  match '/privacy_policy', to: 'static_pages#privacy_policy', :as => "privacy"
  match '/terms_of_service', to: 'static_pages#terms_of_service', :as => "terms"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
