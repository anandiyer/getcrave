namespace :solr do

  task :reindex => :environment do

    classes_to_reindex = [ MenuItem, Restaurant ]

    classes_to_reindex.each do |klass|
      klass.find_in_batches(:batch_size => 10) do |records|
        puts "Indexing a new batch..."
        records.each do |record|
          begin
            record.solr_index
          rescue RSolr::RequestError => e
            puts "RSolr::RequestError - #{e.message} - on #{record.inspect}"
          rescue Exception => e
            puts "Exception - #{e.message} - on #{record.inspect}"
          end
        end
      end
      
    end

  end
end