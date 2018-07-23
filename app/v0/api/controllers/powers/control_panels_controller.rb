class V0
  module Api
    module Controllers

      get '/power/control_panel' do
        view :'powers/control_panels/show'
      end

    end
  end
end
