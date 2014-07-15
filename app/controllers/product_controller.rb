class ProductController < ApplicationController


  #TOKEN="ylbmessa"
  skip_before_filter :verify_authenticity_token
  #before_action :authenticate, except: [:index]


  def create

    #product=Product.new();

    title=params[:title]
    assembly_id=params[:assembly_id]

    #repository_path = "git@github.com:assemblymade/"+title+".git"
    #g=Git.init(title)


    #GitPusher.push();

    #g.add(:all=>true)

    #g.push(g.remote(repository_path))
    return_string="you created a product called "+title
    render json: {message: return_string}

  end

  def index
    render json: {message: 'what did you expect here?'}
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
