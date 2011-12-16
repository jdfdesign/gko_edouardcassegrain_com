GkoCassegrainCom::Application.routes.draw do
  # overwrite admin/blog#show to point to admin/posts#index instead
  # can this be simplified? haven't had any luck putting it into the resource block
  get 'admin/sites/:site_id/game_lists/:game_list_id', :to => 'admin/games#index'

  namespace :admin do
    resources :sites do
      resources :game_lists do
        resources :games do
          collection do
            get :move
          end
        end
      end
    end
  end

  match 'game_lists/:game_list_id/feed', 
  :to => 'games#index', 
  :as => 'game_list_feed', 
  :defaults => {:format => "atom"}
  
  get 'game_lists/:game_list_id/categories/:category_id', 
  :to => 'games#index', 
  :as => :game_list_category
  
  get 'game_lists/:game_list_id/tags/:sticker_id', 
  :to => 'games#index', 
  :as => :game_list_sticker
  
  get 'game_lists/:game_list_id', 
  :to => 'games#index', 
  :as => :game_list
  
  get 'game_lists/:game_list_id/*permalink.:format', 
  :to => "games#show"
  get 'game_lists/:game_list_id/*permalink', 
  :to => "games#show", :as => :game_list_game
end
