require 'scaa/campus/importer'
require 'scaa/campus/geocoder'
require 'scaa/campus/indexer'

namespace :scaa do
  namespace :campus do
    task :import do
      Scaa::Campus::Importer.new.import!
    end

    task :geocode do
      Scaa::Campus::Geocoder.new.geocode!
    end

    task :index do
      Scaa::Campus::Indexer.new.index!
    end

    task rebuild: %w(import geocode index)
  end
end
