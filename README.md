# Psych Remake

## Git Repository: https://github.com/AndrewHulme/Psych

## Technologies used:

- Docker
  - for environment setup & deployment
  - (https://docs.docker.com/get-started/)
- TypeScript, React and Redux
  - (https://www.chadlumley.com/posts/setup-react-redux-typescript-2019-edition)
- Ruby on Rails (in API mode)
  - Action Cable
    - websockets library, used for bidirectional connection between client and server
    - (https://edgeguides.rubyonrails.org/action_cable_overview.html)
    - Example of rails app using Action Cable (https://iridakos.com/programming/2019/04/04/creating-chat-application-rails-websockets)
  - GraphQL with Apollo
    - Query language
    - (https://engineering.musefind.com/build-a-graphql-api-in-under-20-minutes-3cdaa774b786)
    - (https://dev.to/isalevine/ruby-on-rails-graphql-api-tutorial-creating-data-with-mutations-39ab)
    - (https://medium.com/@bruno_boehm/reactjs-ruby-on-rails-api-heroku-app-2645c93f0814)
  - Sidekiq
    - Background Processor
    - (https://github.com/mperham/sidekiq)
    - (https://gojek-ghost.zysk.in/how-we-use-sidekiq-to-process-background-jobs/)

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

## Set up a development environment

### Backend

1. Install [Docker](https://docs.docker.com/install/) under your system

   - [Docker for MacOS](https://docs.docker.com/docker-for-mac/install/)
   - [Docker for Windows](https://docs.docker.com/docker-for-windows/install/)
   - [Docker for Ubuntu](https://docs.docker.com/install/linux/docker-ce/ubuntu/)

2. [Install Docker Compose](https://docs.docker.com/compose/install/)

3. Go to the project directory and execute the command `docker-compose up --build`.
   Wait for the docker -compose command to complete.

To connect to the container with the application, you must run the `docker-compose exec web bash`.

To view the list of running containers, you must run the `docker-compose ps` or `docker ps`.

4. connect to the web container using `docker-compose exec web bash` and setup the databases with `rails db:setup`.

The launched application is available at http://backend.lvh.me.

### Frontend

1. Navigate to client folder from main folder \$ cd client
2. Install npm if you don't already have it
3. Install all dependencies \$ npm install
4. Start the server \$ npm start
5. Navigate to http://localhost:3000 in your browser

---

README created with the help of https://stackedit.io/app#
