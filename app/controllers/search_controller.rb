class SearchController < ApplicationController
  layout "general"
  
  def index
#    you can use it, its live 60 minutes
#    cookies[:lat]
#    cookies[:long]

    if (params[:q] && !params[:q].empty?)
      current_model = params[:search_restaurants] ? Restaurant : MenuItem

#      @search = Sunspot.search(current_model) do
#          fulltext(params[:q])
#          paginate :page => 1, :per_page => ITEMS_PER_PAGE
#      end
#      @results = @search.results
      @results = current_model.find(100,1001,1002)

      partial_2_show = "result_all"
      partial_2_show = "result_restaurants" if params[:search_restaurants]
      partial_2_show = "result_menu_items" if params[:search_dishes]


      respond_to do |format|
        format.html
#        format.xml  { render :xml => @results.to_xml }
#        format.json  { render :json => @results.to_json }
        format.js  { render :partial => partial_2_show}
      end
    end
  end
end
