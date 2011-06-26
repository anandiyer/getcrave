class SearchController < ApplicationController
  layout "general"
  
  def index
#    you can use it, its live 60 minutes
#    cookies[:lat]
#    cookies[:long]

# Right now, we cannot really fine-tune by distance, so we're ignoring 
# the 'within' query string parameter

    if (params[:q] && !params[:q].empty?)
      
      q = params[:q]

      # default is all results
      partial_2_show = "result_all"
      
      if (params[:search_restaurants] || params[:category] == "restaurant")
        current_model = Restaurant
        partial_2_show = "result_restaurants" 
      elsif (params[:search_dishes] || params[:category] == "dishes")
        current_model = MenuItem
        partial_2_show = "result_menu_items" 
        
        #TODO: we're only appending labels to dishes right now
        #eventually we want to be able to do this for restaurants as well
        #so that we can find Vegan food at 21st Amendment for example
        if (params[:labels])
          # Append the labels to the end of the query
          q = q + " " + params[:labels]
        end
        
      end

      if (current_model == Restaurant) || (current_model == MenuItem) 
        @search = Sunspot.search(current_model) do
            fulltext(q)
            paginate :page => 1, :per_page => ITEMS_PER_PAGE
        end
      else
        # default search mode, search both Restaurants and Menu Items
        @search = Sunspot.search(Restaurant, MenuItem) do
          fulltext(q)
          paginate :page => 1, :per_page => ITEMS_PER_PAGE
        end
      end

      @results = @search.results

      respond_to do |format|
        format.html
#        format.xml  { render :xml => @results.to_xml }
#        format.json  { render :json => @results.to_json }
        format.js  { render :partial => partial_2_show}
      end
    end
  end
end
