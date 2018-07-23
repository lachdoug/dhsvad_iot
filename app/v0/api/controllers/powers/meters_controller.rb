class V0
  module Api
    module Controllers


      get '/power/meters' do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        @meters = Meter.all
        @meters.to_json
      end

      get '/power/meters/:id' do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        @meter = Meter.find( params[:id] )
        @meter.data.to_json
      end

      post '/power/meters' do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        @meter = Meter.create params[:meter]
        @meter.to_json
      end

      delete '/power/meters/:id' do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        @meter = Meter.find( params[:id] )
        @meter.destroy
        {}.to_json
      end

    end
  end
end
