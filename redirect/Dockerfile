# Based on https://github.com/padcom/rackup-docker/blob/master/Dockerfile
FROM ruby:3.0.2

RUN mkdir -p /usr/src/app
WORKDIR /usr/src/app

ONBUILD RUN /bin/bash -c "apt-get update && apt-get install -y \$(cat packages) --no-install-recommends && rm -rf /var/lib/apt/lists/*"

ADD . /usr/src/app
RUN bundle install

EXPOSE 9292

CMD ["rackup", "-o", "0.0.0.0" ]