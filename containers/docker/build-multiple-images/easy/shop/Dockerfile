# Shop microservice
FROM alpine:3.15.0
COPY --from=build-result-tag /build/shop.txt /opt/shop.txt
ENTRYPOINT exec cat /opt/shop.txt
