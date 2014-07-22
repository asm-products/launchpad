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
    def edit_travis(heroku_app_name)
      travis_file_path='nodetemplate/.travis.yml'
      lines=File.readlines(travis_file_path)
      lines[10]="  app: "+heroku_app_name+"\n"
      f=File.open(travis_file_path,'w')
      lines.each do |x| f.write(x) end
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
