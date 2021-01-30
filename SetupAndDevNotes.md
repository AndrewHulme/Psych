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


## Other

setting up cookies/sessions
  create welcomecontroller and a spec
    visitor_key should be set
    visitor_key should be stored in db
    visitor_key should persist on second request

aim is to be able to identify users via websockets without signing them in.

we can store the visitor key in local storage or sth...

will need the actioncable js package later on for the front end https://www.npmjs.com/package/actioncable

https://pragmaticstudio.com/tutorials/rails-session-cookies-for-api-authentication




https://guides.rubyonrails.org/action_controller_overview.html#session
https://pragmaticstudio.com/tutorials/rails-session-cookies-for-api-authentication
https://backend-development.github.io/rails_websockets.html
https://guides.rubyonrails.org/security.html#sessions
https://www.npmjs.com/package/actioncable
https://stackoverflow.com/questions/38617791/client-javascript-for-action-cable-rails-5
https://stackoverflow.com/questions/598933/how-do-i-change-the-default-www-example-com-domain-for-testing-in-rails


creating a room
  gql mutation to create a room.
  response sends back a room (or error message)
  then front end should subscribe to the room channel, using the room id
  connection should now be established



game flow: required model changes

Note: System should be designed from a game-first perspective, not a history-first perspective. Prioritise the game-flow first and foremost, and the storing of game history second.

how do we then see which users were in a room? just check the user's answers/votes


mutations/queries required:

- game leader says that next round can start mutation (optional)
  - dont make a constraint on starting the next round in the back end. just provide it as an indicator for the front end, so that we can choose if we want the game leader to start the next round at their own will



  (non-urgent for now)
- current_room query (return user.room)


actioncable

- user should subscribe to a room, after joining

- ensure that users can leave a game mid way through, and maybe even rejoin.



auth changes
- install jwt
- install devise
- install devise_jwt
- ensure that confirmations & passwords are not required

  def valid_password?(password)
    (password.blank? && !admin?) ? true : super
  end

  def password_required?
    (new_record? && !admin?) ? false : super
  end

- ensure that tokens work from frontend
