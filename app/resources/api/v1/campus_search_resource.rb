module Api
  module V1
    class CampusSearchResource < CampusResource
      model_name 'Campus'
      attribute :distance

      def distance
        context[:distance]
      end
    end
  end
end
