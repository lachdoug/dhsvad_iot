class V0
  module Api
    module Controllers

      get '/' do
        if settings.map_app
          redirect '/map'
        else
          redirect '/power'
        end
        # begin
        #   authenticate_user
        #   redirect '/map'
        # rescue NonFatalError => e
        #   redirect '/sign_in' if e.status_code == 401
        #   raise
        # end
      end

    end
  end
end
