FROM ruby:3.0.4-slim

ENV BUNDLE_PATH=/usr/local/bundle \
    BUNDLE_JOBS=4 \
    BUNDLE_RETRY=3 \
    RAILS_ENV=development

RUN apt-get update -qq && \
    apt-get install -y --no-install-recommends build-essential libsqlite3-dev sqlite3 && \
    rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bash", "-lc", "rm -f tmp/pids/server.pid && bundle exec rails db:prepare && bundle exec rails tailwindcss:build && bundle exec rails server -b 0.0.0.0 -p 3000"]
