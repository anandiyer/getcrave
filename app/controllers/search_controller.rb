class SearchController < ApplicationController
  layout "general"
  
  def index


    if (params[:q] && !params[:q].empty?)
      current_model = params[:search_restaurants] ? Restaurant : MenuItem

      if (current_model == MenuItem)
        @search = Sunspot.search(current_model) do
          fulltext(params[:q])
          paginate :page => 1, :per_page => ITEMS_PER_PAGE
          order_by :avg_rating, :desc
          order_by :num_ratings, :desc
        end
      else
        @search = Sunspot.search(current_model) do
          fulltext(params[:q])
          paginate :page => 1, :per_page => ITEMS_PER_PAGE
        end
      end
      
      @results = @search.results

      respond_to do |format|
        format.html
        format.xml  { render :xml => @results.to_xml }
        format.json  { render :json => @results.to_json }
      end
    end
  end
end
