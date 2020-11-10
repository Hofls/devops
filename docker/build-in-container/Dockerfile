# Build your project based on build with dependencies:
FROM your-company.com/project-name:build-image as build-project
COPY . /build
RUN cd /build && \
    mvn clean install -settings ./mavenSettings.xml -B
