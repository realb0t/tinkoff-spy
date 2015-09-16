class RatesController < ApplicationController

  before_filter :ensure_json_request, only: :current

  def index
  end

  def current
    render json: {
      USD: Stats.new('USD').represent,
      EUR: Stats.new('EUR').represent
    }
  end

end
