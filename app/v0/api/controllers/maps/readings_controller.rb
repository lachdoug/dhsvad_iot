class V0
  module Api
    module Controllers

      get '/map/readings/:id' do
        begin
          @reading = GpsReading.find( params[:id] )
        rescue ActiveRecord::RecordNotFound
          @reading = GpsReading.last
        end
        view :'maps/readings/show'
      end

      post "/map/readings" do
        response['Access-Control-Allow-Origin'] = '*'
        request.body.rewind
        @request_payload = JSON.parse request.body.read, symbolize_names: true
        GpsReading.create_from_post( @request_payload ) if @request_payload[:type] == "position"
      end

    end
  end
end
