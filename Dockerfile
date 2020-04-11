FROM ruby:2.7.1-alpine3.11

# build_base contains tools for compiling gems from source
# postgresql-dev is used when installing the pg gem
# tzdata is used by Rails for timezone info
RUN apk update && apk add git nodejs yarn build-base postgresql-dev tzdata

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app

COPY entrypoint.sh /usr/bin
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
