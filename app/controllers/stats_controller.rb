class StatsController < ApplicationController
  def index
    @period_options = period_options
    @selected_period = params[:period] || 1
    @stats = Stats.new(current_user, @selected_period.to_i.weeks)
  end

  private

  def period_options
    [
      { id: 1, name: '1 Week' },
      { id: 2, name: '2 Weeks' },
      { id: 4, name: '1 Month' },
      { id: 12, name: '3 Months' },
      { id: 24, name: '6 Months' }
    ].map do |option|
      OpenStruct.new(option)
    end
  end
end
