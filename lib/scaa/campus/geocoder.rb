require 'geocoder'

module Scaa
  module Campus
    # geocode list of scaa campuses
    class Geocoder
      def initialize(klass: ::Campus, field: :address, sleep_time: 0.1)
        @klass = klass
        @field = field
        @sleep_time = sleep_time
      end

      def geocode!
        @klass.find_each do |model| # FIXME: make this concurrent
          next unless geo = ::Geocoder.search(model[@field]).first
          model.update! latitude: geo.latitude, longitude: geo.longitude
          sleep @sleep_time # for rate limiting ;(
        end
      end
    end
  end
end
