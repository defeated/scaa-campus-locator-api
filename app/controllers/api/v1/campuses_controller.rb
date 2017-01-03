module Api
  module V1
    class CampusesController < JSONAPI::ResourceController
      def search
        pin   = search_params[:pin]
        dist  = search_params[:dist]
        uom   = search_params[:uom]

        geo = Geocoder.search(pin).first
        if geo
          point = geo.coordinates.join ','
        else
          return head :bad_request
        end

        # FIXME: extract to query object
        q = ::Campus.__elasticsearch__.search(
          query: {
            bool: {
              filter: {
                geo_distance: {
                  distance: "#{dist}#{uom}",
                  location: point
                }
              }
            }
          },
          sort: {
            _geo_distance: {
              location: point,
              order: 'asc',
              unit: uom
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
          distance = "#{result[:sort].first.round}#{uom}"
          klass.new record, distance: distance
        end
        serializer = JSONAPI::ResourceSerializer.new klass
        collection = serializer.serialize_to_hash resources

        render json: collection
      end

      private

      def search_params
        @search_params ||= params.permit(%i(pin dist uom)).tap do |hash|
          hash[:pin]  ||= 'Boston, MA, US'
          hash[:dist] ||= '50'
          hash[:uom]  ||= 'mi'
        end
      end
    end
  end
end
