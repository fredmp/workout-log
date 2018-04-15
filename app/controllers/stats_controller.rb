class StatsController < ApplicationController
  def index
    @stats = Stats.new
  end
end
