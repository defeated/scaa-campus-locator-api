module Api
  module V1
    class CampusResource < JSONAPI::Resource
      immutable
      key_type :uuid
      attributes :name, :address, :url, :latitude, :longitude

      def latitude
        @model.latitude.to_f
      end

      def longitude
        @model.longitude.to_f
      end
    end
  end
end
