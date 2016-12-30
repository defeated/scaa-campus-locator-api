module Scaa
  module Campus
    # build search index of scaa campuses
    class Indexer
      def initialize(klass: ::Campus)
        @klass = klass
      end

      def index!
        @klass.__elasticsearch__.create_index! force: true
        @klass.__elasticsearch__.import
      end
    end
  end
end
