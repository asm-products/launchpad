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

      heroku_git_repo='git@heroku.com:'+name+'.git'
      puts "Connecting to New Heroku remote #{heroku_git_repo}}"

      m='eval "$(ssh-agent -s)"'
      m=m+'ssh-add launchpad;'
      exec(m)
      sleep(2)
      m=''
      m=m+'Wagnerian0pera;'

      puts 'stuff should happen here'

      m=m+'ssh -T git@github.com;'
      m=m+'cd nodetemplate;'
      m=m+'git init;'
      m=m+'git add .;'
      m=m+'git commit -m "initial commit";'
      m=m+'git remote add heroku '+heroku_git_repo+'.git;'
      m=m+'git push heroku master;'
      exec(m)

      #exec('ssh-add launchpad')
      #exec('Wagnerian0pera')
      #exec('ssh -T git@github.com')
      #exec('yes')


      #Dir.chdir('nodetemplate') do

      #  exec('git init')
      #  exec('git add .')
      #  exec('git commit -m "initial commit"')
      #  exec('git remote add heroku '+heroku_git_repo+'.git')
      #  exec('git push heroku master')
      #  puts "pushed something?"
      #end
    end


  end
end
