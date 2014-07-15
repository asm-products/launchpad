class ProductController < ApplicationController


  #TOKEN="ylbmessa"
  skip_before_filter :verify_authenticity_token
  #before_action :authenticate, except: [:index]


  def create

    #product=Product.new();

    title=params[:title]
    #assembly_id=params[:assembly_id]


    GitPusher.create_repo(title)


    return_string="you created a product called "+title
    render json: {message: return_string}

  end

  def index
    render json: {message: 'what did you expect here?'}
  end

  def add
    repo_name=params[:repo_name]
    file_path=params[:file_path]
    file_contents=params[:file_contents]
    GitPusher.add_file(repo_name,file_path,file_contents)
    render json: {message: 'you are trying to add a file'}
  end

  def getgit
    a=GitPusher.get_contents(params[:repo_name], params[:path])
    #render json: {message: 'here find contents of git repository'}

    if a.nil?
      render json: {message: "The Repository is empty..."}
    else
      #render a.body
      render json: JSON.parse(a.body)

    end

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
