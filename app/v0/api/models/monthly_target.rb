class V0
  module Api
    module Models
      class MonthlyTarget < ActiveRecord::Base

        belongs_to :meter

      end
    end
  end
end
