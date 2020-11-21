# Setup / Dev notes

This can be a nice place for explaining solutions, findings, "gotcha" and other interesting things that are worth saving for future reference

## Docker

- Docker Explained:
  - containers
  - images
  - dockerfile
  - docker-compose
  - bash

- The command used to create the rails app skeleton was: ```bundle exec rails new . --api --database=postgresql --skip-bundle```
  - ```bundle exec``` was necessary because we didn't have immediate access to the rails binaries from the docker container.
  - ```bundle exec``` lets us run binaries and other ruby/gem code from the command line, in the context of the directory's Gemfile.

- When creating files from a docker container, they are (often, depending how you setup docker in the first place...) created as the root user. Hence, after creating the rails skeleton (or after using  ```rails generate [migration/model/whatever...]```), I had to run ```sudo chown -R $USER:$USER .``` from the root directory of the project, in order to change the owner of the files from the root user to the current user. If the root user is the owner of the files, then you need root permmission to change them, which is not so great.


## Rails

- Paperclip gem used to be the go-to tool for handling uploads to cloud storage services, e.g. S3. Now, ActiveStorage, a native module in Rails, handles this. https://guides.rubyonrails.org/active_storage_overview.html
