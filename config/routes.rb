GkoCassegrainCom::Application.routes.draw do
  
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

  namespace :admin do
    resources :sites do
      resources :game_lists do
        resources :games do
          member do
            get :toggle_in_homepage
          end
          collection do
            get :move
          end
        end
      end
    end
  end

end
