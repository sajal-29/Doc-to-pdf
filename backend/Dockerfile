# Stage 1: Build the Spring Boot backend
FROM maven:3.9.8-amazoncorretto-21-debian-bookworm AS backend-build
WORKDIR /app
COPY pom.xml ./
RUN mvn dependency:go-offline
COPY /src/ ./src
RUN mvn clean package -Dmaven.test.skip=true

# Stage 2: Create the final image
FROM openjdk:21-jdk-slim-bullseye
RUN apt-get update && apt-get install -y iputils-ping
RUN apt-get install -y net-tools
RUN apt-get install -y curl
WORKDIR /app
COPY --from=backend-build /app/target/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]