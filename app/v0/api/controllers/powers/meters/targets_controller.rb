class V0
  module Api
    module Controllers


      get '/power/meters/:meter_id/targets' do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        @meter = Meter.find( params[:meter_id] )
        @meter.monthly_targets.all.to_json
      end

      post '/power/meters/targets' do
        response['Access-Control-Allow-Origin'] = '*'
        content_type :json, charset: 'utf-8'
        @meter = Meter.find( params[:meter_id] )
        @meter.update_monthly_target params[:target][:month], params[:target][:consumption]
        @meter.monthly_targets.all.to_json
      end

    end
  end
end
