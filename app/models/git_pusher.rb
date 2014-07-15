class GitPusher




  class << self

    Token="0debf5ae8c10c176e546c81da74eefbf638480f0"

    def push(repo_name)
      repo_url="https://github.com/asm-products/"+repo_name+".git"
      #g=Git.init(repo_name)
      #r=g.add_remote(repo_name,repo_url)
      g=authenticate()


    end


    def create_repo(repo_name)


    #g=authenticate().
    orgname="assemblymade"
    create_repo_url="https://api.github.com/orgs/#{orgname}/repos"



    a=HTTParty.post(create_repo_url, :body => {:name=>repo_name}.to_json,
    :headers => {"Authorization" => "token #{Token}",
    "User-Agent" => "Launchpad",
    'Content-Type' => 'application/json'
    }
    )
    puts a


    end


  def add_file(repo_name, file_path, file_contents)

    orgname="assemblymade" #inelegant duplication here

    add_file_url="https://api.github.com/repos/#{orgname}/#{repo_name}/contents/#{file_path}"

    contents=Base64.encode64(file_contents)
    puts contents

    a=HTTParty.put(add_file_url,
    :body=>{#:path=>file_path,
      :message=>"Adding File #{file_path}",
      :content=>contents}.to_json,
    :headers => {"Authorization" => "token #{Token}",
    "User-Agent" => "Launchpad",
    'Content-Type' => 'application/json'
    }
    )
    puts a

  end


  def get_contents(repo_name, path)
    orgname="assemblymade" #inelegant duplication here

    get_contents_url="https://api.github.com/repos/#{orgname}/#{repo_name}/contents/#{path}"


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

  def add_folder(local_path)

  end



  end
end
