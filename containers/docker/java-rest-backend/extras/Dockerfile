FROM openjdk:8-alpine
ADD rest-backend.jar rest-backend.jar
# Must have in image "openjdk:8-alpine", to connect to container via ssh:
RUN apk add bash
EXPOSE 8080
CMD java -jar -Xms120M -Xmx120M rest-backend.jar

