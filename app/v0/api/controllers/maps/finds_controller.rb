class V0
  module Api
    module Controllers

      post '/map/find' do
        datetime = DateTime.parse( "#{params[:find][:date]}T#{params[:find][:time]}#{params[:find][:offset]}" ) + 1.second
        @reading = GpsReading.where( "timestamp < ?", datetime ).last || GpsReading.first
        redirect "/map/readings/#{@reading.id}"
      end

    end
  end
end
