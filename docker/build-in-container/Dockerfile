# Create image for build (with all the dependencies):
FROM maven:3.6.3-openjdk-15 as image-for-build
COPY . /build
RUN cd /build && \
	mvn clean install -settings ./mavenSettings.xml -B && \
	rm -rf /build/*

# Build your project based on build with dependencies:
FROM your-company.com/project-name:build-image as build-project
COPY . /build
RUN cd /build && \
    mvn clean install -settings ./mavenSettings.xml -B
