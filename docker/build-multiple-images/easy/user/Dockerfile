# User microservice
FROM alpine:3.15.0
COPY --from=build-result-tag /build/user.txt /opt/user.txt
ENTRYPOINT exec cat /opt/user.txt
