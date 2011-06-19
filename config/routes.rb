Crave::Application.routes.draw do 
  resources :following, :as => "user_followings", :controller => "user_followings"
  
  resources :ratings, :as => "menu_item_ratings", :controller => "menu_item_ratings" do
    resources :helpful, :as => "menu_item_rating_helpfuls", :controller => "menu_item_rating_helpfuls" do
      collection do
        get 'count'
      end
    end
  end

  resources :helpful, :as => "menu_item_rating_helpfuls", :controller => "menu_item_rating_helpfuls"

  resources :items, :as => "menu_items", :controller => "menu_items" do

    resources :ratings, :as => "menu_item_ratings", :controller => "menu_item_ratings" do
      collection do
        get 'avg_rating'
      end 
    end

    member do
      get 'show_reviews'
      post 'upload_photo'
    end
    collection do
      get 'search', 'location', 'show_menu_items_nearby' , 'nearby_loading'
    end
  end

  resources :places, :as => "restaurants", :controller => "restaurants" do
    resources :items, :as => "menu_items", :controller => "menu_items"
    collection do
      get 'search', 'show_restaurants_nearby'
    end
    member do
      get 'details'
    end
  end

  resources :users do
    member do
      get "saved", "following", "followers", "following_reviews"
    end

    resources :ratings, :as => "menu_item_ratings", :controller => "menu_item_ratings"
  end
  
  resources :saved, :as => "user_saved_menu_items", :controller => "user_saved_menu_items" do 	
    collection do
      get "show_menu_items_saved"
    end
  end
  
  resources :restaurant_label_associations
  resources :restaurant_cuisine_associations
  resources :restaurant_labels
  resources :restaurant_cuisines  
  resources :menu_label_associations
  resources :menu_item_review_comments
  resources :menu_labels
  resources :menu_item_photos
  resources :menu_item_ingredients
  resources :ingredients
  resources :menu_item_prices
  resources :search
  
  match '/foodies', :to => 'users#following_reviews'
  match '/auth/:provider/callback', :to => 'sessions#create'  
  match '/signout' => 'sessions#destroy', :as => :signout
  match '/nearby' => 'menu_items#nearby_loading', :as => :nearby

end
