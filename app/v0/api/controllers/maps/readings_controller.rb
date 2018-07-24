class V0
  module Api
    module Controllers

      get '/map/readings/:id' do
        @reading = GpsReading.find( params[:id] )
        view :'maps/readings/show'
      end

      post "/map/readings" do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        request.body.rewind
        @request_payload = JSON.parse request.body.read
        $stderr.puts "Received GPS reading data: #{@request_payload}"
        @request_payload.to_json
      end

    end
  end
end
