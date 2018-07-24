class V0
  module Api
    module Models
      class GpsReading < ActiveRecord::Base

        def self.create_from_post( reading )
          nema_longitude = reading[:longitude]
          nema_latitude = reading[:latitude]
          nema_hemisphere = ( reading[:lat_dir] || reading[:latt_dir] ) == "S" ? -1 : 1
          latitude = ( nema_latitude[0..-8].to_f + nema_latitude[-7..-1].to_f / 60 ) * nema_hemisphere
          longitude = nema_longitude[0..-8].to_f + nema_longitude[-7..-1].to_f / 60
          self.create( latitude: latitude, longitude: longitude, timestamp: Time.now.utc )
        end
        # curl --header "Content-Type: application/json" --data '{ "type": "position", "time_stamp": "001512.000", "longitude": "15118.9509", "lat_dir": "S", "latitude": "3330.9095","altitude": "9.4" }' http://admin:password@localhost:3030/map/readings --verbose

        def date
          timestamp.strftime('%m/%d/%Y')
        end

        def time
          timestamp.strftime('%H:%M')
        end

        # def is_first?
        #   id == self.class.first.id
        # end

        # def is_last?
        #   id == self.class.last.id
        # end

      end
    end
  end
end
