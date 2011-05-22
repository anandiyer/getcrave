class SearchController < ApplicationController
  
  def index
    if (params[:q] && !params[:q].empty?)
      @search = Sunspot.search(Restaurant, MenuItem) do
        fulltext(params[:q])
        paginate :page => 1, :per_page => 100
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
