Refinery::Core::Engine.routes.append do

  # Frontend routes
  namespace :products do
    resources :products, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :products, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :products, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end


  # Frontend routes
  namespace :categories do
    resources :categories, :path => '', :only => [:index, :show]
  end

  # Admin routes
  namespace :categories, :path => '' do
    namespace :admin, :path => 'refinery' do
      resources :categories, :except => :show do
        collection do
          post :update_positions
        end
      end
    end
  end

end
