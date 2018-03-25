FROM centos:7.4.1708
#
# UTF-8 by default / Adding JDK Path
#
ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    JAVA_HOME=/opt/jdk \
    PATH=/opt/jdk/bin:$PATH

# Setting timezone
RUN rm /etc/localtime &&\
    ln -s /usr/share/zoneinfo/Europe/Paris /etc/localtime

# Upgrading centos
RUN yum update -y

# Downloading and extracting JDK
RUN curl -jksSL https://download.java.net/java/GA/jdk10/10/binaries/openjdk-10_linux-x64_bin.tar.gz \
    | tar -xzf - -C /opt &&\
    ln -s /opt/jdk-10 /opt/jdk

COPY lib/* /lib/
ADD runner.sh /
RUN chmod u+x /runner.sh
COPY src/HttpServerLauncher.java HttpServerLauncher.java
RUN /opt/jdk/bin/javac -cp lib/aws-java-sdk-1.11.301.jar HttpServerLauncher.java

CMD ["/runner.sh"]