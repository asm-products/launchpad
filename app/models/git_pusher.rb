class GitPusher



  class << self

    def push(repo_name)
      repo_url="https://github.com/asm-products/"+repo_name+".git"
      #g=Git.init(repo_name)
      #r=g.add_remote(repo_name,repo_url)
      g=authenticate()


    end


    def create_repo(repo_name)

    token="0debf5ae8c10c176e546c81da74eefbf638480f0"
    #g=authenticate().
    orgname="assemblymade"
    create_repo_url="https://api.github.com/orgs/#{orgname}/repos"



    a=HTTParty.post(create_repo_url, :body => {:name=>repo_name}.to_json,
    :headers => {"Authorization" => "token #{token}",
    "User-Agent" => "Launchpad",
    'Content-Type' => 'application/json'
    }
    )
    puts a


    end



    def authenticate()
      token="0debf5ae8c10c176e546c81da74eefbf638480f0"

      g=Github.new :oauth_token => token
      puts g
      #postdata={}



      return g
    end


  end
end
