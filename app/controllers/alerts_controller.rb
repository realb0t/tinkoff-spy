class AlertsController < ApplicationController

  before_filter :find_alert, only: :show
  before_filter :ensure_json_request 

  layout false

  def create
    @alert = Alert.new(alert_params)
    if @alert.valid? && @alert.save
      redirect_to @alert
    else
      render json: { error: @alert.errors }, status: 400
    end
  end

  def show
    if @alert
      render json: @alert
    else
      render json: { error: 'Not exist alert with id' + params[:id] }, status: 404
    end
  end

  protected

  def find_alert
    @alert = Alert.find_by_id(params[:id])
  end

  def alert_params
    params.require(:alert)
      .permit(:currency, :deal_type, :sign, :value, :email)
  end

end
