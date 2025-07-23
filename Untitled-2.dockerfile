

FROM ruby:3.1.4-alpine AS base

WORKDIR /student_app

RUN apt-get update -qq && apt-get install --no-install-recommends -y build-essential \
    nodejs \
    postgresql-client && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

ENV RAILS_ENV='development' \
    BUNDLE_DEPLOYMENT='1' \
    BUNDLE_PATH='/usr/local/bundle' \
    BUNDLE_WITHOUT='development'

FROM base AS build

RUN apt-get update -qq && apt-get install -y \
  build-essential git pkg-config && \
  rm -rf /var/lib/apt/lists /var/cache/apt/archives

COPY Gemfile Gemfile.lock ./
RUN bundle install && \
  rm -rf ~/.bundle/ "${BUNDLE_PATH}"/ruby/*/cache "${BUNDLE_PATH}"/ruby/*/bundler/gems/*/.git && \
  bundle exec bootsnap precompile --gemfile  

COPY . .

RUN bundle exec bootsnap precompile app/ lib/

FROM base

COPY --from=build "${BUNDLE_PATH}" "${BUNDLE_PATH}"
COPY --from=build /student_app /student_app

RUN groupadd --system --gid 1000 rails && \
  useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash && \
  chown -R rails:rails db log storage tmp

USER 1000:1000

ENTRYPOINT ["/rails/bin/docker-entrypoint"]

EXPOSE 3000
CMD ["./bin/rails", "server", "-b", "0.0.0.0"]

    