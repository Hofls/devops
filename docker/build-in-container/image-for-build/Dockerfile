# Create image for build (with all the dependencies):
FROM maven:3.6.3-openjdk-15 as image-for-build
COPY . /build
RUN cd /build && \
	mvn clean install -settings ./mavenSettings.xml -B && \
	rm -rf /build/*
