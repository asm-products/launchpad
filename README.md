launchpad
=========


Startup Page API



To create an empty Github Repository under /Assemblymade

  POST   /Product/generate
      with parameters in JSON object
        repo_name       # string
        path            # string, '' for root
        file_contents   # string, converted to Base64 internally



To get the contents of a Github Repository under /Assemblymade

  GET     /Product/getgit
        with parameters in JSON object
          repo_name  
          path       #this is the path within /Assemblymade/:repo_name
