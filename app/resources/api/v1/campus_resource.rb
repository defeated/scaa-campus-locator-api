class Api::V1::CampusResource < JSONAPI::Resource
  immutable

  key_type :uuid

  attributes :name, :address, :url, :latitude, :longitude
end
