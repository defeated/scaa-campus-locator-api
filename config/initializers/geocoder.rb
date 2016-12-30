Geocoder.configure lookup: :google,
                   use_https: true,
                   api_key: Rails.application.secrets.geocoding_api_key
