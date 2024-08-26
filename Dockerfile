FROM ruby:3.0.2

RUN mkdir /worker-eligibility
WORKDIR /worker-eligibility

COPY Gemfile /worker-eligibility/Gemfile
COPY Gemfile.lock /worker-eligibility/Gemfile.lock

RUN bundle install && bundle update --bundler

COPY . /worker-eligibility
