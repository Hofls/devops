FROM maven:3.6.3-openjdk-15 as build-project
COPY . /build
RUN --mount=type=cache,id=project-cache17,target=/root/.m2 cd /build && \
	mvn clean install -settings ./mavenSettings.xml
# "id=project-cache17" is optional, only if you want a separate cache for each project (deafult = value of target)