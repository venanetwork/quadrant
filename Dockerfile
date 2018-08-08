FROM golang:1.9 AS gobuild

WORKDIR /go/src/github.com/venanetwork/quadrant
RUN go get \
  github.com/venanetwork/crypto/ed25519 \
  github.com/golang/crypto/blake2b \
  github.com/pkg/errors \
  github.com/dgraph-io/badger

COPY . ./

RUN go build -o quadrant .


FROM debian:8-slim

COPY --from=gobuild /go/src/github.com/venanetwork/quadrant/quadrant /quadrant

ENTRYPOINT ["/quadrant"]
