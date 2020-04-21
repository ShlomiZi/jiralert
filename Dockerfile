FROM golang:1.12.0 AS builder
COPY . /go/src/github.com/free/jiralert
RUN mkdir -p /go/src/github.com/free/jiralert
WORKDIR /go/src/github.com/free/jiralert
RUN GO111MODULE=on GOBIN=/tmp/bin make

FROM quay.io/prometheus/busybox-linux-amd64:latest

COPY --from=builder /go/src/github.com/free/jiralert/jiralert /bin/jiralert

ENTRYPOINT [ "/bin/jiralert", "-config", "/bin/config/jiralert.yml" ]

