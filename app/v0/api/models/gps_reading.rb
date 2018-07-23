class V0
  module Api
    module Models
      class GpsReading < ActiveRecord::Base

        # attr_accessor :offset

        # def ymdDate
        #   @date ||= timestamp.strftime('%Y-%m-%d')
        # end

        def date
          timestamp.strftime('%m/%d/%Y')
        end

        def time
          timestamp.strftime('%H:%M')
        end

        # def dateLocal( offset )
        #   timestamp.change( offset: offset ).strftime('%Y-%m-%d')
        # end
        #
        # def timeLocal( offset )
        #   timestamp.change( offset: offset ).strftime('%H:%M')
        # end





        def is_first?
          id == self.class.first.id
        end

        def is_last?
          id == self.class.last.id
        end

        # def local(offset)
        #   byebug
        #   timestamp.change offset: offset
        # end

      end
    end
  end
end
