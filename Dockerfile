FROM ruby:2.6.5-alpine

RUN apk add --no-cache --update build-base \
  linux-headers \
  git \
  postgresql-dev \
  nodejs \
  yarn \
  tzdata

ENV APP_PATH /app

WORKDIR $APP_PATH
ADD Gemfile $APP_PATH
ADD Gemfile.lock $APP_PATH
RUN gem list bundler
RUN gem install bundler -v 1.17.3
RUN gem list bundler
RUN bundle install
COPY . APP_PATH
EXPOSE 3000
