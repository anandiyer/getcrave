Crave::Application.routes.draw do 

  resources :user_saved_menu_items do
    collection do
      get "show_menu_items_saved"
    end
  end

  resources :user_followings


  resources :menu_item_review_comments
  
  resources :menu_item_ratings do
    resources :menu_item_rating_helpfuls do
      collection do
        get 'count'
      end
    end
  end

  resources :menu_item_rating_helpfuls
  
  resources :menu_label_associations

  resources :menu_labels

  resources :menu_item_photos

  resources :menu_item_ingredients

  resources :ingredients

  resources :menu_item_prices

  resources :menu_items do
    resources :menu_item_ratings do
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

  resources :restaurants do
    resources :menu_items
    collection do
      get 'search', 'show_restaurants_nearby'
    end
  end

  resources :users do
    resources :menu_item_ratings
    resources :user_saved_menu_items
    resources :user_followings
  end
  
  resources :search
  
  match '/auth/:provider/callback', :to => 'sessions#create'  
  match '/signout' => 'sessions#destroy', :as => :signout

end
