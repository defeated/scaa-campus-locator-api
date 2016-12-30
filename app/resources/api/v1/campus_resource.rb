class Api::V1::CampusResource < JSONAPI::Resource
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
