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
      #`mkdir ./.ssh/config`
      #`echo "IdentityFile /app/launchpad" > ~/.ssh/config`


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
