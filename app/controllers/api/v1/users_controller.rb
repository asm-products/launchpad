 module Api
    module V1
      class UsersController < ApplicationController

        def index
          render json: {message: "something happened!"}
        end


      end
    end
  end
