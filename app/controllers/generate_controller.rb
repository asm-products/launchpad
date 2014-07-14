class GenerateController < ApplicationController

  def index
    render json: {message: 'hey something happened'}, status: 200
  end

  def receive
    render json: {message: 'i hear you!'}, status:200
  end

end
