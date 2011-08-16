task :customreindex do
  MenuItem.find_in_batches(batch_size => 10).each do |articles|
    articles.each do |article|
      begin
        article.solr_index
      rescue RSolr::RequestError => e
        puts "ERROR - #{e.message} on #{article.inspect}"
      end
    end
  end
end