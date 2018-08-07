class V0
  module Api
    module Controllers

      get '/map' do
        redirect "/map/readings/#{GpsReading.last.id}"
      end

    end
  end
end
