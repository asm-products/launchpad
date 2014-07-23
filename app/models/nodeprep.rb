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


      htoke="371c0b38-bce1-4483-b6ab-a66c73d16a17"
      auth=Base64.strict_encode64(":#{htoke}")
      puts "AUTH #{auth}"

      #Travis::CLI::Encrypt.run_cli('encrypt',ENV['HEROKU_AUTH_TOKEN'],'-r',"assemblymade/#{title}")
      `cd ~/nodetemplate`
      key=(`travis encrypt #{auth} -r assemblymade/#{title} --skip-version-check`)
      `cd ~`
      puts key


      lines[10]="    secure : #{key}"

      f=File.open(travis_file_path,'w')
      lines.each do |x| f.write(x) end
      f.write(" before_deploy:\n- git fetch --unshallow")
      f.close unless f==nil
      #puts File.read(travis_file_path)





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
