#!/usr/bin/env bash
if [ "$RAILS_ENV" = 'production' ]
then
  su - app -p -c 'cd /home/app/web && bundle exec rails db:create db:migrate'
fi
