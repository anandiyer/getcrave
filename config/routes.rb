Crave::Application.routes.draw do  

  match '/auth/:provider/callback', :to => 'sessions#create'
  match '/auth/facebook/'=> 'sessions#create', :as => :facebook_auth

  match '/signout' => 'sessions#destroy', :as => :signout
  

  resources :menu_item_review_comments

  resources :menu_item_rating_helpfuls

  resources :menu_item_ratings 
  
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
    end
    collection do
      get 'search', 'location'
    end
  end

  resources :restaurant_label_associations

  resources :restaurant_cuisine_associations

  resources :restaurant_labels

  resources :restaurant_cuisines

  resources :restaurants do
    resources :menu_items
    collection do
      get 'search'
    end
  end

  resources :users do
    resources :menu_item_ratings
  end
  
  match '/auth/:provider/callback', :to => 'sessions#create'  
  match '/signout' => 'sessions#destroy', :as => :signout

end
