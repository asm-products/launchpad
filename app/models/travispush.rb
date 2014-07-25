class Travispush

  def self.push(repo_path)
    Travis.access_token = ENV['TRAVIS_AUTH_TOKEN']
    #client=Travis::Client.new()
    puts "Hello #{Travis::User.current.name}!"
    #Travis::User.current.sync
    rails = Travis::Repository.find(repo_path)
    rails.enable
    puts "Enabled Github Repo on Travis-CI"
  end
end
