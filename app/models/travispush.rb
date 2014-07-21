class Travispush

  #def initialize(travis)
  #  @travis = travis
  #end

  def self.push(repo_path)
    #sleep(4.0)
    Travis.access_token = "zPfGpvUGrci1cFk198Bdow"
    #client=Travis::Client.new()
    puts "Hello #{Travis::User.current.name}!"
    Travis::User.current.sync
    rails = Travis::Repository.find(repo_path)
    rails.enable
    puts "Enabled Github Repo on Travis-CI"
  end

end

#object = Travispush.new(t)
#object.push('asdf/asdf')
