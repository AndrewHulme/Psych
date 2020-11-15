# Psych Remake

## Technologies used:
  - Docker
    - for environment setup & deployment
    - (https://docs.docker.com/get-started/)
  - Ruby on Rails (in API mode)
    - Action Cable
      - websockets library, used for bidirectional connection between client and server
      - (https://edgeguides.rubyonrails.org/action_cable_overview.html)
    - Graphql
      - Query language
      - (https://engineering.musefind.com/build-a-graphql-api-in-under-20-minutes-3cdaa774b786)
      - (https://dev.to/isalevine/ruby-on-rails-graphql-api-tutorial-creating-data-with-mutations-39ab)
      - (https://medium.com/@bruno_boehm/reactjs-ruby-on-rails-api-heroku-app-2645c93f0814)
    - Sidekiq
      - Background Processor
      - (https://github.com/mperham/sidekiq)
      - (https://gojek-ghost.zysk.in/how-we-use-sidekiq-to-process-background-jobs/)
  - Typescript React with Redux
    - (https://www.chadlumley.com/posts/setup-react-redux-typescript-2019-edition)



## MVP Features

- "Before starting a game"
  - new user creates a basic profile (by adding name, and maybe tagline & profile picture)
- "Starting a game"
  - user creates a game lobby
  - user joins a game lobby
  - user, who created the game lobby, starts the game when there are two or more players
- "Playing a round"
  - All players see the new unfinshed sentence for the round at the same time
  - player submits an answer for the round
  - players can see which other players have submitted an answer
  - When all players have submitted an answer, all players see the list of answers at the same time
  - player can vote on one answer from the round
  - when all players have voted, all players can see the updated scoreboard at the same time
- "Finishing the game"
  - all players see the final scoreboard at the same time
  - user, who created the game lobby, can start a new game lobby.


## Extra, Post-MVP Features:

- chat service / chatroom
- authentication
- viewing game history
- updating profile
- levelling system
- sound effects
- collaborating with a visual artist

README created with the help of https://stackedit.io/app#
