Crave::Application.routes.draw do 

  resources :following, :as => "user_followings", :controller => "user_followings"

  resources :menu_item_review_comments
  
  resources :ratings, :as => "menu_item_ratings", :controller => "menu_item_ratings" do
    resources :helpful, :as => "menu_item_rating_helpfuls", :controller => "menu_item_rating_helpfuls" do
      collection do
        get 'count'
      end
    end
  end

  resources :helpful, :as => "menu_item_rating_helpfuls", :controller => "menu_item_rating_helpfuls"
  
  resources :menu_label_associations

  resources :menu_labels

  resources :menu_item_photos

  resources :menu_item_ingredients

  resources :ingredients

  resources :menu_item_prices

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
      get 'search', 'location', 'show_menu_items_nearby'
    end
  end

  resources :restaurant_label_associations

  resources :restaurant_cuisine_associations

  resources :restaurant_labels

  resources :restaurant_cuisines

  resources :places, :as => "restaurants", :controller => "restaurants" do
    resources :items, :as => "menu_items", :controller => "menu_items"
    collection do
      get 'search', 'show_restaurants_nearby'
    end
  end

  resources :users do
    member do
      get "saved", "following", "followers"
    end

    resources :ratings, :as => "menu_item_ratings", :controller => "menu_item_ratings"
  end
  
  resources :search
  
  match '/auth/:provider/callback', :to => 'sessions#create'  
  match '/signout' => 'sessions#destroy', :as => :signout

end
