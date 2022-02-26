# Shop microservice
FROM openjdk:15-alpine
COPY --from=build-result-tag /build/shop-infra/build/libs/shop.jar /opt/shop.jar
EXPOSE 8599 7599
ENTRYPOINT exec java -jar /opt/shop.jar --server.port=8599
