class Herokutalker

  class << self

    HTOKEN=ENV['HEROKU_AUTH_TOKEN']

    def create_app(name)

      heroku=Heroku::API.new(:api_key => HTOKEN)

      heroku.post_app('name'=>name)

    end


  end
end
