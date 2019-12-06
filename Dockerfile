FROM alpine:3.10

MAINTAINER Yves Bouckaert <yves@bouckaert>

ENV APP_ROOT=/app  \
    USER=yves  \
    GROUP=yves \
    BUNDLE_PATH=/usr/local/bundle

ENV BUILD_PACKAGES ruby bash curl-dev ruby-dev build-base

RUN apk update && \
    apk upgrade && \
    apk add $BUILD_PACKAGES && \
    rm -rf /var/cache/apk/*

RUN gem install bundler --no-document
RUN gem install rubocop --no-document
RUN gem install json --no-document

RUN addgroup -g 1000 -S $GROUP && \
    adduser -u 1000 -S $USER -G $GROUP

RUN mkdir $APP_ROOT $BUNDLE_PATH && \
    chown 1000:1000 $APP_ROOT $BUNDLE_PATH

USER $USER
WORKDIR $APP_ROOT
ADD . $APP_ROOT

COPY Gemfile* $APP_ROOT/

COPY . .

RUN bundle install
