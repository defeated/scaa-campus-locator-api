require 'scaa/campus/importer'
require 'scaa/campus/geocoder'
require 'scaa/campus/indexer'

namespace :scaa do
  namespace :campus do
    task import: :environment do
      Scaa::Campus::Importer.new.import!
    end

    task geocode: :environment do
      Scaa::Campus::Geocoder.new.geocode!
    end

    task index: :environment do
      Scaa::Campus::Indexer.new.index!
    end

    task rebuild: %w(import geocode index)
  end
end
