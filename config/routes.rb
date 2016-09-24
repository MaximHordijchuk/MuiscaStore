Rails.application.routes.draw do
  devise_for :buyers, skip: :registrations
  devise_scope :buyer do
    resource :registration,
    only: [:new, :create],
    path: 'buyers',
    path_names: { new: 'sign_up' },
    controller: 'devise/registrations'
  end

  resources :product_attachments
  resources :products
  resources :categories
  resources :orders

  root to:'main#index'
  get '/about' => 'main#about', as: 'about'

  get '/cart' => 'cart#index', as: 'cart'
  post '/add_product' => 'cart#add', as: 'add_product'
  patch '/update_product' => 'cart#update', as: 'update_product'
  delete '/remove_product' => 'cart#remove', as: 'remove_product'

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
