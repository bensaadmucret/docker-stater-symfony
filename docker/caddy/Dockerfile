FROM caddy:alpine AS caddy-build

FROM alpine:latest

LABEL maintainer="github.com/caddyserver"

RUN set -eux; \
    apk --update add --no-cache \
    ca-certificates \
    mailcap \
    libcap

COPY --from=caddy-build /usr/bin/caddy /usr/bin/caddy

RUN addgroup -S caddy && \
    adduser -D -S -s /sbin/nologin -G caddy caddy && \
    setcap cap_net_bind_service=+ep `readlink -f /usr/bin/caddy` && \
    /usr/bin/caddy version

VOLUME ["/etc/caddy", "/var/www/html"]

RUN touch /etc/nsswitch.conf && echo 'hosts: files dns' > /etc/nsswitch.conf

COPY Caddyfile /etc/caddy/Caddyfile

RUN mkdir -p /var/www/html && chown -R caddy:caddy /var/www/html

USER caddy

EXPOSE 80 443

WORKDIR /var/www/html

CMD ["caddy", "run", "--config", "/etc/caddy/Caddyfile", "--adapter", "caddyfile"]