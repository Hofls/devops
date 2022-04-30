FROM openjdk:15-alpine
ADD lector.jar lector.jar
EXPOSE 8099
CMD java \
    -XX:MaxRAMPercentage=80.0 \
    -Duser.timezone=Europe/Paris \
    -jar lector.jar
