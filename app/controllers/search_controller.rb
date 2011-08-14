class SearchController < ApplicationController
  layout "general"
  
  def index
#    you can use it, its live 60 minutes
#    cookies[:lat]
#    cookies[:long]

# Right now, we cannot really fine-tune by distance, so we're ignoring 
# the 'within' query string parameter

    if (params[:lat] && params[:long])
      @origin = [params[:lat].to_f, params[:long].to_f]
    end


    if (params[:q] && !params[:q].empty?)
      
      q = params[:q]
        
      #TODO: we're only appending labels to dishes right now
      #eventually we want to be able to do this for restaurants as well
      #so that we can find Vegan food at 21st Amendment for example
      if (params[:labels])
        # Append the labels to the end of the query
        q = q + " " + params[:labels]
      end

      if (params[:search_restaurants] || params[:category] == "restaurant")
        
        partial_2_show = "result_restaurants" 
        
        @search = Sunspot.search(Restaurant) do
            # Ignoring labels for restaurants
            fulltext(params[:q])
            paginate :page => 1, :per_page => ITEMS_PER_PAGE
        end
         
        @results = @search.results

        respond_to do |format|
          format.html
          format.xml  { render :xml => @results.to_xml(:methods => :distance) }
          format.json  { render :json => @results.to_json(:methods => :distance) }
          format.js  { render :partial => partial_2_show}
        end
        
      elsif (params[:search_dishes] || params[:category] == "dishes")
        
        partial_2_show = "result_menu_items" 

        @search = Sunspot.search(MenuItem) do
          fulltext(q)
          paginate :page => 1, :per_page => ITEMS_PER_PAGE
          order_by :avg_rating, :desc
          order_by :num_ratings, :desc
        end
            
        @results = @search.results
        if (@origin)
          @results.sort_by_distance_from(@origin)
        end

        respond_to do |format|
          format.html
          format.xml  { render :xml => @results.to_xml(:methods => :distance, :include =>  [:restaurant, :menu_item_avg_rating_count, :menu_item_photos]) }
          format.json  { render :json => @results.to_json(:methods => :distance, :include =>  [:restaurant, :menu_item_avg_rating_count, :menu_item_photos]) }
          format.js  { render :partial => partial_2_show}
        end
        
      else
        # default search mode, search both Restaurants and Menu Items
        
        partial_2_show = "result_all"
        
        @search = Sunspot.search(Restaurant, MenuItem) do
          fulltext(q)
          paginate :page => 1, :per_page => ITEMS_PER_PAGE
        end
        
        @results = @search.results

        respond_to do |format|
          format.html
          format.xml  { render :xml => @results.to_xml }
          format.json  { render :json => @results.to_json }
          format.js  { render :partial => partial_2_show}
        end
      end

    end
  end
end
