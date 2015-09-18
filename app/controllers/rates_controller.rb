class RatesController < ApplicationController

  before_filter :ensure_json_request, only: :current

  def index
  end

  def current
    stats_json = Rails.cache.fetch(:rates_current_stats, expires_in: 5.minutes) do
      Stats.represent.to_json
    end

    render text: stats_json, format: :json
  end

end
