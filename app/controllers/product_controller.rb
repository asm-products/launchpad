class ProductController < ApplicationController

  skip_before_filter :verify_authenticity_token
  #before_action :authenticate, except: [:index]


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

    GitPusher.create_repo(title)

    heroku_app_name=title+"_assembled"
    Herokutalker.create_app(heroku_app_name)
    puts "Heroku App #{heroku_app_name} assembled"


    d=Nodeprep.list_node_contents()
    puts "Directory Info Here"
    puts d.to_s

    k=0

    d.each do |file_path|

      k=k+1
      m=k.to_s+" / "+d.length.to_s
      puts m

      #puts file_path
      repo_path=file_path


      if !File.directory?(file_path)
        file_contents=File.read(file_path)
        repo_path.slice!(0,13)
        GitPusher.add_file(title,repo_path, file_contents)

        puts "Added file #{file_path} to #{title} at #{repo_path}"

      end

    end

    render json: {message: 'Files Moved to New Repo'}

  end


  def new
  end

  def edit
  end

  def show
  end

  def update
  end

  def destroy

  end

#  private
#    def authenticate
#        authenticate_or_request_with_http_token do |token,option|
#          token==TOKEN
#    end
#  end


end
