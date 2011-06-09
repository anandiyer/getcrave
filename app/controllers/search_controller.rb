class SearchController < ApplicationController
  layout "general"
  
  def index
    if (params[:q] && !params[:q].empty?)
      if !is_almazom?
        @search = Sunspot.search(Restaurant, MenuItem) do
          fulltext(params[:q])
          paginate :page => 1, :per_page => 100
        end
        @results = @search.results
      else

#        TODO:Remove me on production
        @results = MenuItem.where("id > 100 AND  id < 110")
      end


      respond_to do |format|
        format.html
        format.xml  { render :xml => @results.to_xml }
        format.json  { render :json => @results.to_json }
      end
    end
  end
end
