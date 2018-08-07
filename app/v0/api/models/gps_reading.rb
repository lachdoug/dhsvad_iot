class V0
  module Api
    module Models
      class GpsReading < ActiveRecord::Base

        def self.create_from_post( reading )
          nmea_longitude = reading[:longitude]
          nmea_latitude = reading[:latitude]
          nmea_hemisphere = ( reading[:lat_dir] || reading[:latt_dir] ) == "S" ? -1 : 1
          latitude = ( nmea_latitude[0..-8].to_f + nmea_latitude[-7..-1].to_f / 60 ) * nmea_hemisphere
          longitude = nmea_longitude[0..-8].to_f + nmea_longitude[-7..-1].to_f / 60
          self.create( latitude: latitude, longitude: longitude, timestamp: Time.now.utc )
        end

        def date
          timestamp.strftime('%m/%d/%Y')
        end

        def time
          timestamp.strftime('%H:%M:%S')
        end

      end
    end
  end
end
