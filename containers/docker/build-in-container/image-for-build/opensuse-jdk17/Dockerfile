FROM opensuse/leap:15.4

RUN zypper install -y wget \
	&& wget https://download.java.net/java/GA/jdk17.0.2/dfd4a8d0985749f896bed50d7138ee7f/8/GPL/openjdk-17.0.2_linux-x64_bin.tar.gz \
	&& zypper install -y tar \
	&& zypper install -y gzip \
	&& tar -xvf openjdk-17.0.2_linux-x64_bin.tar.gz

ENV JAVA_HOME="/jdk-17.0.2" \
	PATH="/jdk-17.0.2/bin:$PATH"