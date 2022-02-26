#!/bin/sh
cd /usr/local/redmine
PLUGIN_NAME=redmine_logs

cp plugins/${PLUGIN_NAME}/Gemfile_for_test plugins/${PLUGIN_NAME}/Gemfile 
bundle install 
bundle exec rake redmine:plugins:migrate
bundle exec rake redmine:plugins:migrate RAILS_ENV=test

initdb() {
    bundle exec rake db:create
    bundle exec rake db:migrate
    bundle exec rake redmine:plugins:migrate

    bundle exec rake db:drop RAILS_ENV=test
    bundle exec rake db:create RAILS_ENV=test
    bundle exec rake db:migrate RAILS_ENV=test
    bundle exec rake redmine:plugins:migrate RAILS_ENV=test
}

initdb

export DB=postgres

initdb

export DB=mysql

initdb