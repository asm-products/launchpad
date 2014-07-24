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

    puts "Attempting to create Github Repo"
    #CREATE GITHUB REPOSITORY
    GitPusher.create_repo(title)

    #CREATE HEROKU REPOSITORY
    Herokutalker.create_app(heroku_app_name)

    #TRANSFER HEROKU APP TO ASSEMBLY ORG
    Herokutalker.transfer_app(heroku_app_name,"assembly")

    node_contents=Nodeprep.list_node_contents()

    #EDIT NODETEMPLATE FILES  --  PRODUCT SPECIFIC INFO, TRAVIS.YML STUFF

    Nodeprep.edit_index_file(title)

    
    Nodeprep.edit_travis(heroku_app_name,title)



    Nodeprep.edit_packagejson(title, heroku_app_name)

    #PUSH NODEJS FILES TO GITHUB

    node_contents.each do |file_path|
      repo_path=file_path
      if !File.directory?(file_path) and file_path!="nodetemplate/."
        file_contents=File.read(file_path)

        #FORMAT REPO NAME TO REMOVE 'nodetemplate/'
        repo_path.slice!(0,13)

        #PUSH EACH FILE TO GITHUB
        GitPusher.add_file(title,repo_path, file_contents)
        puts "Added file #{file_path} to #{title} at #{repo_path}"

      end
    end

    travis_path="assemblymade/#{title}"
    puts travis_path

    puts "Enabling on Travis-CI"
    Travispush.push(travis_path)

    #FINAL COMMIT NECESSARY
    puts "Adding Readme"
    readme_contents="Welcome to #{title}!\n\nThis is your starter NodeJS product page."
    GitPusher.add_file(title,'readme.md',readme_contents)

    render json: {message: 'Files Moved to New Repo'}

  end


def make_heroku_app
  heroku_app_name=params[:title]
  render json: {message: 'making heroku app'}
  Herokutalker.create_app(heroku_app_name)

end

def travisenable
  title=params[:title]
  repo_path='assemblymade/'+title
  Travispush.push(repo_path)

  puts "Adding Readme"
  readme_contents="Welcome to #{title}!\n\nThis is your starter NodeJS product page."
  GitPusher.add_file(title,'readme.md',readme_contents)

  render json: {message: 'trying to enable repo on travis ci'}

end


def hello
  render json: {message: "A Product shall you make."}
end

def edit_travis
  title=params[:title]
  herokuapp="#{title}-assembled"
  Nodeprep.edit_travis(herokuapp,title)
  render json: {message: "you are editing the travis file"}
end

def transfer_heroku
  heroku_app_name="#{params[:title]}-assembled"
  Herokutalker.transfer_app(heroku_app_name,"assembly")
  render json: {message: "You are transferring heroku ownership to Assembly"}

end


end
