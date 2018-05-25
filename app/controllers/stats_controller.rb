class StatsController < ApplicationController
  def index
    @period_options = period_options
    @selected_period = params[:period] || 1
    @stats = Stats.new(current_user, @selected_period.to_i.weeks)
  end

  private

  def period_options
    [
      { id: 1, name: I18n.t(:x_weeks, scope: [:datetime, :distance_in_words], count: 1) },
      { id: 2, name: I18n.t(:x_weeks, scope: [:datetime, :distance_in_words], count: 2) },
      { id: 4, name: I18n.t(:x_months, scope: [:datetime, :distance_in_words], count: 1) },
      { id: 12, name: I18n.t(:x_months, scope: [:datetime, :distance_in_words], count: 3) },
      { id: 24, name: I18n.t(:x_months, scope: [:datetime, :distance_in_words], count: 6) }
    ].map do |option|
      OpenStruct.new(option)
    end
  end
end
