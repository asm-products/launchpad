launchpad
=========


Startup Page API



To create an empty Github Repository under /Assemblymade

  POST   /Product/generate
      with parameters in JSON object
        'title' : THE REPO NAME



To get the contents of a Github Repository under /Assemblymade

  GET     /Product/getgit
        with parameters in JSON object
          repo_name  
          path       #this is the path within /Assemblymade/:repo_name


To add a file to an existing Github Repository under /Assemblymade


   PUT   /Product/addfile

       with parameters in JSON object
         repo_name
         path            #note that the path should include the name of the file created
                         # and it will create subfolders on its own if specified
                         # do not include '/' for root, but merely 'fileatroot'
                         # or 'subfolder/file'
         file_contents     #AS A STRING
