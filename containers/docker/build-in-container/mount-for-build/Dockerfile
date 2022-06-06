FROM maven:3.6.3-openjdk-15 as build-project
COPY . /build
RUN --mount=type=cache,target=/root/.m2 cd /build && \
	mvn clean install -settings ./mavenSettings.xml
