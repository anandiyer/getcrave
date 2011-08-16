namespace :solr do
  task :reindex => :environment do
    classes_to_reindex = [ MenuItem, Restaurant ]
    classes_to_reindex.each do |klass|
      klass.find_in_batches(batch_size => 10).each do |records|
        records.each do |record|
          begin
            record.solr_index
          rescue RSolr::RequestError => e
            puts "ERROR - #{e.message} on #{article.inspect}"
          end
        end
      end
    end
  end
  
end