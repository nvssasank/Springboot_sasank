FROM openjdk:17-jdk-slim
 
LABEL maintainer="nvssasank1219@gmail.com"
 
WORKDIR /app
 
COPY target/simple-hello-Sasank-1.0.0.jar simple-hello-Sasank-1.0.0.jar
 
EXPOSE 8080
 
ENTRYPOINT [ "java", "-jar", "simple-hello-Sasank-1.0.0.jar" ]
