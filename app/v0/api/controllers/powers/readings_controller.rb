class V0
  module Api
    module Controllers

      get '/power/readings' do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        @readings = Reading.all
        @readings.to_json
      end

    end
  end
end
