FROM alpine:latest

ARG JAVA_VERSION=17
ARG MAVEN_VERSION=3.8.5

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8
# You can change it to your TimeZone
ENV TZ=Asia/Shanghai

ENV JAVA_HOME=/usr/lib/jvm/zulu${JAVA_VERSION}-ca
ENV MAVEN_HOME=/opt/maven
ENV PATH=${MAVEN_HOME}/bin:$PATH

WORKDIR /app

RUN apk add --no-cache wget tzdata git && \
    cp /usr/share/zoneinfo/${TZ} /etc/localtime && \
    echo ${TZ} > /etc/timezone && \
    apk del tzdata && \
    wget -q https://cdn.azul.com/public_keys/alpine-signing@azul.com-5d5dc44c.rsa.pub \
    -P /etc/apk/keys/ && \
    apk add --repository https://repos.azul.com/zulu/alpine --no-cache zulu${JAVA_VERSION}-jre && \
    wget https://dlcdn.apache.org/maven/maven-3/${MAVEN_VERSION}/binaries/apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    tar xzvf apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    rm apache-maven-${MAVEN_VERSION}-bin.tar.gz && \
    mv apache-maven-${MAVEN_VERSION} /opt/maven && \
    git clone https://github.com/HydroCarbon/EurekaServer.git -b Java17 && \
    cd EurekaServer && \
    mvn clean package && \
    rm -rf ~/.m2/repository && \
    mv target/EurekaServer-1.0.0.jar /app && \
    cd ~ && rm -rf /app/EurekaServer/

EXPOSE 8999

ENTRYPOINT ["java", "-jar", "/app/EurekaServer-1.0.0.jar"]
