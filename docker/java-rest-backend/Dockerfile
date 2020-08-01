FROM openjdk:8-alpine
VOLUME /tmp
ADD rest-backend.jar rest-backend.jar
# Needed to connect to container via ssh:
RUN apk add bash
EXPOSE 8080
CMD java -jar rest-backend.jar
