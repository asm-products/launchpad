class Travispush

  #def initialize(travis)
  #  @travis = travis
  #end

  def self.push(repo_path, access_token)
    Travis.access_token = access_token
    puts "Hello #{Travis::User.current.name}!"

    rails = Travis::Repository.find_repository(repo_path).enable
    puts "Enabled Github Repo on Travis-CI"
  end

end

#object = Travispush.new(t)
#object.push('asdf/asdf')
