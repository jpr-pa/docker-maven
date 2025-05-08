# Use Maven with Java 17
FROM maven:3.9.6-eclipse-temurin-17 as builder

# Set working directory
WORKDIR /usr/src/app

# Copy the project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package

# Run stage
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=builder /usr/src/app/target/demo-0.0.1-SNAPSHOT.jar app.jar

# Expose the default Spring Boot port
EXPOSE 8080

# Run the application
ENTRYPOINT ["java", "-jar", "app.jar"]
