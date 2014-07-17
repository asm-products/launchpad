class ProductController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create


    title=params[:title]

    GitPusher.create_repo(title)


    return_string="you created a product called "+title
    render json: {message: return_string}

  end

  def index
    render json: {message: 'what did you expect here?'}
  end

  def addfile
    repo_name=params[:repo_name]
    file_path=params[:path]
    file_contents=params[:file_contents]
    GitPusher.add_file(repo_name,file_path,file_contents)
    render json: {message: 'you are trying to add a file'}
  end

  def getgit
    a=GitPusher.get_contents(params[:repo_name], params[:path])
    if a.nil?
      render json: {message: "The Repository is empty..."}
    else
      #render a.body
      render json: JSON.parse(a.body)
    end
  end


  def deploy

    title=params[:title]
    heroku_app_name=title+"-assembled"

    #CREATE GITHUB REPOSITORY      WORKS, OPTIMAL
    GitPusher.create_repo(title)

    #CREATE HEROKU REPOSITORY     WORKS, NON-OPTIMAL
    Herokutalker.create_app(heroku_app_name)
    puts "Heroku App #{heroku_app_name} assembled"


    d=Nodeprep.list_node_contents()
    k=0

    #EDIT NODETEMPLATE FILES     WORKS, VERY NON-OPTIMAL
    Nodeprep.edit_index_file(title)
    Nodeprep.edit_travis(heroku_app_name)
    Nodeprep.edit_packagejson(title, heroku_app_name)

    #PUSH TO GITHUB              WORKS, OK
    d.each do |file_path|

      k=k+1
      m=k.to_s+" / "+d.length.to_s
      #SHOW FILE COMMIT PROGRESS OF TOTAL
      puts m

      repo_path=file_path


      if !File.directory?(file_path)
        file_contents=File.read(file_path)

        #FORMAT REPO NAME TO REMOVE 'nodetemplate/'
        repo_path.slice!(0,13)

        #PUSH EACH FILE TO GITHUB
        GitPusher.add_file(title,repo_path, file_contents)
        puts "Added file #{file_path} to #{title} at #{repo_path}"

      end
    end

    Herokutalker.heroku_build(heroku_app_name)   #DOESNT WORK YET

    render json: {message: 'Files Moved to New Repo'}

  end



end
