# User microservice
FROM openjdk:15-alpine
COPY --from=build-result-tag /build/user-infra/build/libs/user.jar /opt/user.jar
EXPOSE 8598 7598
ENTRYPOINT exec java -jar /opt/user.jar --server.port=8598
