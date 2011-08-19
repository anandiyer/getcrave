namespace :solr do

  task :reindex => :environment do

    classes_to_reindex = [ MenuItem, Restaurant ]

    classes_to_reindex.each do |klass|
      klass.find_in_batches(:batch_size => 10) do |records|
        puts "Indexing a new batch..."
        attempt = 0
        begin
          Sunspot.index(records)
        rescue Exception => e
          puts "Exception - #{e.message} - retrying..."
          retry if (attempt += 1) < 2
        end
      end
    end

  end
end