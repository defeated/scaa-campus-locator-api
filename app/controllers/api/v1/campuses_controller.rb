module Api
  module V1
    class CampusesController < JSONAPI::ResourceController
      def search
        # default to lat, lon for Boston, MA, US
        spot = params[:spot] || [42.3600825, -71.0588801].join(',')
        dist = params[:dist] || '50'
        unit = params[:unit] || 'mi'

        # FIXME: extract to command object
        q = ::Campus.__elasticsearch__.search(
          query: {
            bool: {
              filter: {
                geo_distance: {
                  distance: "#{dist}#{unit}",
                  location: spot
                }
              }
            }
          },
          sort: {
            _geo_distance: {
              location: spot,
              order: 'asc',
              unit: unit
            }
          }
        )

        # FIXME: extract to command object
        results    = q.results.to_a
        records    = q.records.to_a
        klass      = CampusSearchResource
        resources  = records.map do |record|
          # find result distance
          result = results.find { |item| item.id == record.id }
          distance = "#{result[:sort].first.round}#{unit}"
          klass.new record, distance: distance
        end
        serializer = JSONAPI::ResourceSerializer.new klass
        collection = serializer.serialize_to_hash resources

        render json: collection
      end
    end
  end
end
