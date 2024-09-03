FROM ruby:3.0.2

RUN mkdir /shift-eligibility
WORKDIR /shift-eligibility

COPY Gemfile /shift-eligibility/Gemfile
COPY Gemfile.lock /shift-eligibility/Gemfile.lock

RUN bundle install && bundle update --bundler

COPY . /shift-eligibility
