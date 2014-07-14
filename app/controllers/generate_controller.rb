class GenerateController < ApplicationController

  def index
    render json: {message: 'hey something happened'}
  end

end
