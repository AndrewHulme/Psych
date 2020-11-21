#!/usr/bin/env bash
# Ruby 2.6.3
bash -lc 'rvm get stable && rvm install ruby-2.6.6 && rvm --default use ruby-2.6.6@backend --create && gem install bundler'
