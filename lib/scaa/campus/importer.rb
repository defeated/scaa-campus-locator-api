require 'scaa/campus/parser'

module Scaa
  module Campus
    # import list of scaa campuses
    class Importer
      def initialize(parser: Parser.new, model: ::Campus)
        @parser = parser
        @model = model
      end

      def import!
        @parser.parse!
        return if @parser.results.empty?

        @model.transaction do
          @model.delete_all
          @parser.results.each { |result| @model.create! result }
        end
      end
    end
  end
end
