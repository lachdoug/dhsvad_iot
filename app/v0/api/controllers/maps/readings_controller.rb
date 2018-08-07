class V0
  module Api
    module Controllers

      get '/map/readings/:id' do
        @deleteable = GpsReading.all - GpsReading.first(4)
        @deleteable.each &:destroy
        begin
          @reading = GpsReading.find( params[:id] )
        rescue ActiveRecord::RecordNotFound
          @reading = GpsReading.last
        end
        view :'maps/readings/show'
      end

      post "/map/readings" do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        request.body.rewind
        @request_payload = JSON.parse request.body.read, symbolize_names: true
        @reading = GpsReading.create_from_post( @request_payload )
        $stderr.puts "Received GPS reading data: #{@request_payload}"
        @request_payload.to_json
      end

    end
  end
end
