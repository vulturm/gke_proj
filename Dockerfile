# MV 2018
FROM alpine:3.4

EXPOSE 8080

ADD app /app

CMD ["/app"]
