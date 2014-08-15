class GitPusher
  class << self
    Token=ENV['GIT_TOKEN']
    Orgname="asm-products"
    def push(repo_name)
      repo_url="https://github.com/asm-products/"+repo_name+".git"
      #g=Git.init(repo_name)
      #r=g.add_remote(repo_name,repo_url)
      g=authenticate()
    end

    def create_repo(repo_name)
    create_repo_url="https://api.github.com/orgs/#{Orgname}/repos"

    a=HTTParty.post(create_repo_url, :body => {:name=>repo_name}.to_json,
    :headers => {"Authorization" => "token #{Token}",
    "User-Agent" => "Launchpad",
    'Content-Type' => 'application/json'
    }
    )
    puts a

    end


  def add_file(repo_name, file_path, file_contents)

    add_file_url="https://api.github.com/repos/#{Orgname}/#{repo_name}/contents/#{file_path}"

    contents=Base64.strict_encode64(file_contents)

    a=HTTParty.put(add_file_url,
    :body=>{
      :path=>file_path,
      :message=>"Adding File #{file_path}",
      :content=>contents}.to_json,
    :headers => {"Authorization" => "token #{Token}",
    "User-Agent" => "Launchpad",
    'Content-Type' => 'application/json'
    }
    )
    return a
  end

  def update_file(repo_name, file_path, file_contents)
    add_file_url="https://api.github.com/repos/#{Orgname}/#{repo_name}/contents/#{file_path}"

    contents=Base64.strict_encode64(file_contents)

    a=HTTParty.put(add_file_url,
    :body=>{
      :path=>file_path,
      :message=>"Adding File #{file_path}",
      :content=>contents}.to_json,
    :headers => {"Authorization" => "token #{Token}",
    "User-Agent" => "Launchpad",
    'Content-Type' => 'application/json'
    }
    )
    return a
  end


  def get_contents(repo_name, path)
    get_contents_url="https://api.github.com/repos/#{Orgname}/#{repo_name}/contents/#{path}"

    a=HTTParty.get(get_contents_url,
    :body=>{#:path=>file_path,
      :path=>path}.to_json,
    :headers => {"Authorization" => "token #{Token}",
    "User-Agent" => "Launchpad",
    'Content-Type' => 'application/json'
    }
    )
    return a
  end

  def send_tree(repo_name,path)
    node_contents=Nodeprep.list_node_contents()

    bigtree={}
    tree=Array.new

    node_contents.each do |file_path|

        if !File.directory?(file_path) and file_path!="nodetemplate/."

        file_contents=File.read(file_path)

        newstuff={}
        newstuff['path']=
        newstuff['mode']=
        newstuff

        tree=tree+[]


      end
    end
  end

  end
end
