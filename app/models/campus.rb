class Campus < ApplicationRecord
  before_validation :normalize_url

  ### Elasticsearch ###################################################
  include Elasticsearch::Model

  mapping do
    indexes :name,     type: 'string'
    indexes :address,  type: 'string'
    indexes :location, type: 'geo_point'
  end

  def as_indexed_json(_opts = {})
    as_json(only: %w(name address)).merge(location: location)
  end
  #####################################################################

  # http://elastic.co/guide/en/elasticsearch/reference/current/geo-point.html
  # Geo-point expressed as a string with the format: "lat,lon"
  def location
    "#{latitude},#{longitude}" if latitude && longitude
  end

  private

  def normalize_url
    return if url.blank? || url.start_with?('http')
    url.prepend 'http://'
  end
end
