class V0
  module Api
    module Models
      class MonthlyReport < ActiveRecord::Base

        belongs_to :meter

        def to_json
          as_json.merge( consumption: random_meter_data ).to_json
        end


        def summarize_data
          update consumption: meter.monthly_consumption_for( timestamp ), target: meter.target_for( timestamp )
        end

        # def random_meter_data
        #   {
        #     history: random_months,
        #     monthToDate: random_month(0)
        #   }
        # end
        #
        # def random_months
        #   Array(1...12).map { |months_ago| random_month(months_ago) }
        # end
        #
        # def random_month(months_ago)
        #   t = Date.today
        #   # byebug
        #   year = t.year
        #   month = t.month - months_ago
        #   if month < 1
        #     month = 12 + month
        #     year = year - 1
        #   end
        #   date = Date.new( year, month )
        #
        #   {
        #     date: date,
        #     consumption: Random.rand(10.0...20.0),
        #     target: Random.rand(10.0...20.0)
        #   }
        #
        # end

      end
    end
  end
end
