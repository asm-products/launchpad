class Herokutalker

  class << self

    HTOKEN= ENV['HEROKU_AUTH_TOKEN']

    def create_app(name)
      heroku=Heroku::API.new(:api_key => HTOKEN)
      heroku.post_app(name: name)
      puts "Heroku App #{name} assembled"
    end

    def heroku_build(name)
      heroku_git_repo='git@heroku.com:'+name+'.git'
      puts heroku_git_repo

      m='cd nodetemplate;'
      m=m+'git init;'
      m=m+'git add .;'
      m=m+'git commit -m "initial commit";'
      m=m+'git remote rm heroku;'
      m=m+'git remote add heroku '+heroku_git_repo+';'
      m=m+'git push heroku master;'
      puts m
      exec(m)

      puts "Connecting to New Heroku remote #{heroku_git_repo}}"
    end

    def transfer_app(heroku_app_name, new_owner)

        htoke=HTOKEN
        auth=Base64.strict_encode64(":#{htoke}")
        puts "AUTH #{auth}"
        transfer_url="https://api.heroku.com/account/app-transfers"
        response=HTTParty.post(transfer_url, :body => {:app=>heroku_app_name,
        :recipient=>new_owner
        }.to_json,
          :headers => {"Accept" => "application/vnd.heroku+json; version=3",
          'Content-Type' => 'application/json',
          'Authorization'=> auth
        }
        )
        puts response
    end

  end
end
