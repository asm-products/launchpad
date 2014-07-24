class Travispush


  def self.push(repo_path)
    #sleep(4.0)
    Travis.access_token = "zPfGpvUGrci1cFk198Bdow"
    #client=Travis::Client.new()
    puts "Hello #{Travis::User.current.name}!"
    #Travis::User.current.sync
    rails = Travis::Repository.find(repo_path)
    rails.enable
    puts "Enabled Github Repo on Travis-CI"

    #travis_file_path='./nodetemplate/.travis.yml'
    #lines=File.readlines(travis_file_path)
    #lines[10] =

  end

end
