class Nodeprep

  class << self
    def list_node_contents

      directory_info= Dir.glob("nodetemplate/**/*")
      return directory_info

    end
  end


end
