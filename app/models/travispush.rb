t= Travis.new(access_token)

class Travispush

  def initialize(travis)
    @travis = travis
  end

  def push(repo_path, access_token)
    puts "Hello #{Travis::User.current.name}!"

    rails = @travis.find_repository(repo_path).enable
    rails.enable
    puts "Enabled Github Repo on Travis-CI"
  end

end

object = Travispush.new(t)
object.push('asdf/asdf')
