require 'pp'
require 'scaa/campus/parser'

namespace :scaa do
  namespace :campus do
    task :import do
      parser = Scaa::Campus::Parser.new
      parser.parse!
      pp parser.results
    end
  end
end
