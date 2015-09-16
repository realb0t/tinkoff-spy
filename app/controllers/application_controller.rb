class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def ensure_json_request  
    return if params[:format] == "json" || request.headers["Accept"] =~ /json/  
    render json: { error: 'Only JSON supported' }, :status => 406  
  end  
end
