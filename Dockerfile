
# Build the Maven project using Java 17
FROM maven:3.8-eclipse-temurin-17 as builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn package

# Use a base image with Java 17
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /app/target/*.jar /app/application.jar
ENTRYPOINT ["java", "-jar", "/app/application.jar"]