FROM golang as builder
LABEL maintainer="Rick Rackow <rrackow@redhat.com>"

# Get go-jsonnet and jsonnet-bundler
CMD go get github.com/google/go-jsonnet/cmd/jsonnet
CMD go get github.com/jsonnet-bundler/jsonnet-bundler/cmd/jb

# Copy all our jsonnet over and prepare assets dir
WORKDIR /jsonnet
COPY jsonnet/ /jsonnet 
CMD mkdir /assets

# Update all our dependecies
CMD jb update

# Render everything
CMD jsonnet -m /asssets

# Grafana base image
FROM grafana/grafana as runner

COPY --from=builder /assets /usr/share/grafana/conf/provisioning/dashboards
