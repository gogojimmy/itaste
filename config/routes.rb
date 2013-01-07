Itaste::Application.routes.draw do
  mount RedactorRails::Engine => '/redactor_rails'

  root :to => "wines#index"
  devise_for :users, path_names: {sign_in: "login", sign_out: "logout"}, :skip => [:sessions], controllers: {omniauth_callbacks: "omniauth_callbacks"}
  devise_scope :user do
    get 'signin' => 'devise/sessions#new', :as => :new_user_session
    post 'signin' => 'devise/sessions#create', :as => :user_session
    delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  match 'signout', to: 'sessions#destroy', as: 'signout'
  get '/sitemap', to: 'sitemap#index'

  resources :users do
    get '/notes', to: "wines#notes"
    resources :lists, only: [:index, :show]
  end

  resources :wines do
    collection do
      get :create_wine, as: :create_wine
      get :facebook_places
    end
  end
  resources :producers, only: [:index, :show]
  resources :foods, only: [:index]
  resources :regions, only: [:index]
  resources :grapes, only: [:index]
  resources :places, only: [:index]
  resources :photos do
    put :set_feature
  end

  resources :lists

  get '/terms', to: 'welcome#terms'
  get '/privacy', to: 'welcome#privacy'

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
