FROM ruby:2.5.7

ENV APP_DIR /var/trans-feed
ADD Gemfile $APP_DIR
RUN gem install bundler
ADD . $APP_DIR
RUN cd $APP_DIR && bundle install && bundle exec jekyll build
