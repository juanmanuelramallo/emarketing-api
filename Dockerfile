FROM ruby:2.3.1
MAINTAINER Juan Manuel Ramallo <ramallojuanm@gmail.com>
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /emarketing-docker
WORKDIR /emarketing-docker
ADD Gemfile /emarketing-docker/Gemfile
ADD Gemfile.lock /emarketing-docker/Gemfile.lock
RUN bundle install
ADD . /emarketing-docker
