class Nodeprep

  class << self
    def list_node_contents

      directory_info= Dir.glob("nodetemplate/**/*", File::FNM_DOTMATCH)
      directory_info.shift
      return directory_info

    end
  end


end
