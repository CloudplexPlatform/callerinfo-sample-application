FROM golang:1.13.6-alpine AS builder

ENV PROJECT github.com/CloudplexPlatform/callerinfo-sample-app
WORKDIR /go/src/$PROJECT

COPY . .
RUN go build -o /callerinfo .

FROM alpine:3.11.2 AS release
RUN apk add --no-cache ca-certificates

WORKDIR /callerinfo
COPY --from=builder /callerinfo ./server
EXPOSE 3550
ENTRYPOINT ["/callerinfo/server"]

