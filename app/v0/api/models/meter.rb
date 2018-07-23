class V0
  module Api
    module Models
      class Meter < ActiveRecord::Base

        has_many :monthly_reports, dependent: :destroy
        has_many :monthly_targets, dependent: :destroy
        has_many :meter_readings, dependent: :destroy

        def report_for( date )
          result = monthly_reports.where( "timestamp = ?", date.beginning_of_month ).first || build_report_for( date )
        end

        def build_report_for( date )
          monthly_reports.create( timestamp: date.beginning_of_month ).tap &:summarize_data
        end

        def target_for( month )
          monthly_targets.where( "month = ?", month ).first || build_target_for( month )
        end

        def build_target_for( month )
          monthly_targets.create( month: month, consumption: 0 )
        end

        def data
          beginning_of_month = Time.now.utc.beginning_of_month
          {
            name: name,
            url: url,
            power: {
              monthToDate: month_to_date_data_for( beginning_of_month ),
              history: history_data_for( beginning_of_month )
            }
          }
        end

        def history_data_for( beginning_of_month )
          result = []
          12.times do |i|
            report = report_for( beginning_of_month - ( i + 1 ).months )
            # target = target_for( beginning_of_month - ( i + 1 ).months )
            result << {
              date: report.timestamp,
              consumption: report.consumption,
              target: report.target
            }
          end
          # byebug
          result.reverse

        end

        def month_to_date_data_for( beginning_of_month )
          {
            consumption: monthly_consumption_for( beginning_of_month ),
            target: target_for( beginning_of_month.month ).consumption
          }
        end

        def monthly_readings_for( beginning_of_month )
          meter_readings.where "timestamp >= ? AND timestamp < ?", beginning_of_month, beginning_of_month.end_of_month
        end

        def monthly_consumption_for( beginning_of_month )
          monthly_readings_for( beginning_of_month ).sum( :consumption )
        end

        def update_monthly_target( month, consumption )
          target_for( month ).update consumption: consumption
        end



      end
    end
  end
end
