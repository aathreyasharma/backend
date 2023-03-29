class ApplicationController < ActionController::API
  def index
    render json: {msg: 'Welcome to Athri API Services'}, status: 200
  end

  def fallback
    render json: {msg: 'Incorrect request'}, status: 400
  end
end
