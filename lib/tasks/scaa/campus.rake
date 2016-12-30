require 'scaa/campus/importer'
require 'scaa/campus/geocoder'

namespace :scaa do
  namespace :campus do
    task :import do
      Scaa::Campus::Importer.new.import!
    end

    task :geocode do
      Scaa::Campus::Geocoder.new.geocode!
    end

    task rebuild: %w(import geocode)
  end
end
