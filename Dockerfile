FROM bitwalker/alpine-elixir-phoenix:1.5.3 as builder

ENV MIX_ENV=prod

# Cache elixir deps
ADD mix.exs mix.lock ./
RUN mix deps.get \
    mix deps.compile

# Same with npm deps
ADD assets/package.json assets/
RUN cd assets && \
    npm install

ADD . .

RUN cd assets && \
    npm run deploy && \
    cd - && \
    mix compile && \
    mix phx.digest && \
    mix release --env=prod

FROM alpine:3.7

# USER default

ARG WEB_PORT=4000
ENV APP_NAME=aws_lightsail \
    # WEB_PORT=$WEB_PORT \
    MIX_ENV=prod

EXPOSE $WEB_PORT

COPY --from=builder /tmp/$APP_NAME.tar.gz .

RUN apk add --no-cache bash && \
    apk add --no-cache openssl-dev && \
    tar -xzf $APP_NAME.tar.gz

CMD ./bin/${APP_NAME} foreground
