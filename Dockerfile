FROM openjdk:17-jdk-slim
 
LABEL maintainer="Srilathamaddasani05@gmail.com"
 
WORKDIR /app
 
COPY target/simple-hello-Srilatha-1.0.0.jar simple-hello-Srilatha-1.0.0.jar
 
EXPOSE 8080
 
ENTRYPOINT [ "java", "-jar", "simple-hello-Srilatha-1.0.0.jar" ]