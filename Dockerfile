FROM ruby:2.5.7

ENV APP_DIR /var/
ADD Gemfile .
RUN gem install bundler
RUN cd $APP_DIR && bundle install
