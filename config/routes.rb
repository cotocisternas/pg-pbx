PgPbx::Application.routes.draw do

  root :to    => 'dashboard#index'

  devise_for :user, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout" }

  resources :users do
    collection { post :import }
  end
  resources :extensions
  resources :dids do
    collection { post :import }
  end
  resources :cdrs
  resources :searches
  get   'dialplans'       => 'dialplans#index',   :as => 'dialplans'
  get   'directory'       => 'directory#index',   :as => 'directory'
  get   'member/:id'      => 'directory#show',    :as => 'member'

end
