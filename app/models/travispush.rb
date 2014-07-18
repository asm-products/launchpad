Class Travispush

  class << self

    def push(repo_path)


    Travis.access_token = "zPfGpvUGrci1cFk198Bdow"
    puts "Hello #{Travis::User.current.name}!"

    rails = Travis::Repository.find(repo_path)
    rails.enable
    puts "Enabled Github Repo on Travis-CI"

  end

  end


end
