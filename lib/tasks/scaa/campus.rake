require 'pp'
require 'scaa/campus/parser'

namespace :scaa do
  namespace :campus do
    task :import do
      parser = Scaa::Campus::Parser.new
      parser.parse!

      return if parser.results.empty?

      Campus.transaction do
        Campus.delete_all
        parser.results.each { |result| Campus.create! result }
      end
    end
  end
end
