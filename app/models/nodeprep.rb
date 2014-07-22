class Nodeprep

  class << self
    def list_node_contents

      directory_info= Dir.glob("nodetemplate/**/*", File::FNM_DOTMATCH)
      return directory_info

    end

  #EDIT NODEJS SERVER FILE
    def edit_index_file(title)

    index_file_name='index.html'
    index_file_path="./nodetemplate/public/freelancer/#{index_file_name}"

    lines=File.readlines(index_file_path)

    #PRODUCT NAME
    lines[3]="var maintext=\"#{title}\"";




    f=File.open(index_file_path,'w')
    lines.each do |x| f.write(x) end
    f.close unless f==nil

    end


  #EDIT TRAVIS FILE with new APP NAME
    def edit_travis(heroku_app_name,title)
      travis_file_path='./nodetemplate/.travis.yml'
      lines=File.readlines(travis_file_path)
      lines[8]="  app: "+heroku_app_name+"\n"
      f=File.open(travis_file_path,'w')
      lines.each do |x| f.write(x) end
      f.close unless f==nil
      #puts File.read(travis_file_path)



      toke="371c0b38-bce1-4483-b6ab-a66c73d16a17"
      auth=Base64.strict_encode64(":#{htoke}")
      puts "AUTH #{auth}"

      #Travis::CLI::Encrypt.run_cli('encrypt',ENV['HEROKU_AUTH_TOKEN'],'-r',"assemblymade/#{title}")
      `cd ~/nodetemplate`
      `travis encrypt #{auth} -r assemblymade/#{title} --add deploy.api_key --skip-version-check`
      `cd ~`

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
