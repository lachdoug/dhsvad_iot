class V0
  module Api
    module Helpers

        def fa( type, text=nil )
          "<i class='fa fa-#{type}'></i>#{ text ? ' ' + text : nil }"
        end


    end
  end
end
