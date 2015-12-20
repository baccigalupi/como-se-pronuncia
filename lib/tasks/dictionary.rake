namespace :dictionary do
  desc "Get word list from Carnegie Mellon"
  task :get_words => :environment do
    Dictionary::GetData.new.perform
  end

  desc "Populate database from word data"
  task :populate => :environment do
    Dictionary::Populator.new.perform
  end
end
