# MV 2018
FROM alpine:3.4

RUN apk -U add curl ca-certificates

EXPOSE 8080

ADD app /app

CMD ["/app"]
