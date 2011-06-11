class SearchController < ApplicationController
  layout "general"
  
  def index


    if (params[:q] && !params[:q].empty?)
      current_model = params[:search_restaurants] ? Restaurant : MenuItem

      @search = Sunspot.search(current_model) do
          fulltext(params[:q])
          paginate :page => 1, :per_page => ITEMS_ON_PAGE
      end
      @results = @search.results
#      @results = current_model.find(100,1001,1002)


      respond_to do |format|
        format.html
        format.xml  { render :xml => @results.to_xml }
        format.json  { render :json => @results.to_json }
      end
    end
  end
end
