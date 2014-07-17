class Herokutalker

  class << self

    HTOKEN=ENV['HEROKU_AUTH_TOKEN']

    def create_app(name)

      heroku=Heroku::API.new(:api_key => HTOKEN)

      heroku.post_app('name'=>name)

      'heroku sharing:transfer assembly --app name'


      #create_heroku_url="https://api.heroku.com/organizations/apps"

      #a=HTTParty.post(create_heroku_url,
      #:body => {:name=>name, :organization=>"assembly"}.to_json,
      #:headers => {
      #"Authorization" => HTOKEN,
      #"Accept" => "application/vnd.heroku+json; version=3",
      ##"User-Agent" => "Launchpad",
      #'Content-Type' => 'application/json'
      #}
      #)
      #puts HTOKEN
      #puts a

    end



    def heroku_build(name)

      heroku_git_repo='git@heroku.com:#{name}.git'

      Dir.chdir('nodetemplate') do
        exec('git init')
        exec('git add .')
        exec('git commit -m "initial commit"')
        exec('git remote add heroku ')
        exec('git push heroku master')
      end
    end


  end
end
