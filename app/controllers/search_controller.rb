class SearchController < ApplicationController
  layout "general"
  
  def index


    if (params[:q] && !params[:q].empty?)
      if !params[:search_restaurants]

#        @search = Sunspot.search(MenuItem) do
#          fulltext(params[:q])
#          paginate :page => 1, :per_page => ITEMS_ON_PAGE*2
#        end
#        @results = @search.results
        @results = MenuItem.find(100,1001,1002)

      else
        @results = Restaurant.find(100,1001,1002)
      end


      respond_to do |format|
        format.html
        format.xml  { render :xml => @results.to_xml }
        format.json  { render :json => @results.to_json }
      end
    end
  end
end
