class Nodeprep


  class << self
    def list_node_contents

      directory_info= Dir.glob("nodetemplate/**/*", File::FNM_DOTMATCH)
      return directory_info

    end

    def get_random_image
      #require 'open-uri'
      url="'http://lorempixel.com/600/400/abstract'"
      open('nodetemplate/public/freelancer/random_image.png', 'wb') do |file|
        file << open(url).read
      end

    end

  #EDIT NODEJS SERVER FILE
    def edit_index_file(title)

      @title=title
      @tagline = "One small step for #{title}, one giant leap for mankind"
      @main_image= "picture.jpg"
      @pitch = "#{title} has tons of synergy.\nIt also interfaces!"
      @assembly_description= "#{title} was deployed by Assembly"

      index_file_name='index.html'
      index_file_path="./nodetemplate/public/freelancer/#{index_file_name}"

      template_file_path="app/views/layouts/website.html.erb"
      template_contents=File.read(template_file_path)
    #  puts template_contents

      newtext=ERB.new(template_contents).result(binding)
      puts newtext

      newfile_path='nodetemplate/public/freelancer/index.html'

      newfile=File.open(newfile_path,'w')
      newfile.write(newtext)

      #newfile.close()

    #  template_contents.close()

    end


  #EDIT TRAVIS FILE with new APP NAME
    def edit_travis(heroku_app_name,title)
      travis_file_path='./nodetemplate/.travis.yml'
      lines=File.readlines(travis_file_path)
      lines[8]="  app: "+heroku_app_name+"\n"

      success=false

      htoke=ENV['HEROKU_AUTH_TOKEN']
      auth=htoke#Base64.strict_encode64(":#{htoke}")
      puts "AUTH #{auth}"

      maxtries=1000
      trycount=0
      sleep(30.0)
      while trycount<maxtries and !success
        sleep(3.0)

        begin

          Travis.access_token = "zPfGpvUGrci1cFk198Bdow"
          #client=Travis::Client.new()
          puts "Travis is trying to sync"
          puts "#{Travis::User.current.name} is logged in"
          Travis::User.current.sync

          key=(`travis encrypt #{auth} -r assemblymade/#{title} --skip-version-check`)

          if $?.success?
            success=true
            puts "SECURE HEROKU KEY GENERATED #{key}"
          end

        rescue
          puts "Connection with Travis failed"

        end

        trycount=trycount+1

      end


      lines[10]="    secure: #{key}"

      f=File.open(travis_file_path,'w')
      lines.each do |x| f.write(x) end
      f.close unless f==nil





    end


  #EDIT PACKAGE.JSON FILE
    def edit_packagejson(title,heroku_app_name)
      packagejson_file_path='nodetemplate/package.json'
      lines=File.readlines(packagejson_file_path)
      lines[1] =   "\"name\":  \"#{heroku_app_name}\",\n"
      lines[10]= "   \"url\": \"https://github.com/assemblymade/#{title}.git\"\n"
      lines[15]= "   \"url\": \"https://github.com/assemblymade/#{title}/issues\" \n"

      f=File.open(packagejson_file_path,'w')
      lines.each do |x| f.write(x) end
      f.close unless f==nil
      #puts File.read(packagejson_file_path)
    end




  end


end
