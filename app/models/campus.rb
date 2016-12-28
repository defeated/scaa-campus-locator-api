class Campus < ApplicationRecord
  before_validation :normalize_url

  private

  def normalize_url
    return if url.blank? || url.start_with?('http')
    url.prepend 'http://'
  end
end
