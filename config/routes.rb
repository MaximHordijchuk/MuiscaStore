Rails.application.routes.draw do
  devise_for :users, skip: :registrations
  devise_scope :user do
    get 'users/sign_up' => 'devise/registrations#new', as: 'new_user_registration'
    post 'users' => 'devise/registrations#create', as: 'user_registration'
  end

  scope '/users' do
    get '/' => 'users#index', as: 'users'
    patch 'grant_admin' => 'users#grant_admin', as: 'grant_admin'
    patch 'prohibit_admin' => 'users#prohibit_admin', as: 'prohibit_admin'
    delete ':id' => 'users#destroy', as: 'user'
  end

  resources :products do
    resources :product_attachments, :except => [:index, :show]
  end
  resources :categories
  resources :orders

  root to:'main#index'
  get '/about' => 'main#about', as: 'about'

  get '/cart' => 'cart#index', as: 'cart'
  post '/add_product' => 'cart#add', as: 'add_product'
  patch '/update_product' => 'cart#update', as: 'update_product'
  delete '/remove_product/:id' => 'cart#remove', as: 'remove_product'
  patch '/increase_amount/:id' => 'cart#increase', as: 'cart_increase'
  patch '/decrease_amount/:id' => 'cart#decrease', as: 'cart_decrease'

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
