module Api
  module V1
    class CampusSearchResource < CampusResource
      attribute :distance

      def distance
        context[:distance]
      end
    end
  end
end
