require 'scaa/campus/importer'

namespace :scaa do
  namespace :campus do
    task :import do
      Scaa::Campus::Importer.new.import!
    end
  end
end
