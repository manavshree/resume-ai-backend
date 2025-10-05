# Use official Java 17 image
FROM openjdk:17-jdk-slim

# Install Maven
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy all files from the backend directory
COPY . .

# Make mvnw executable
RUN chmod +x mvnw

# Build the application
RUN ./mvnw clean package -DskipTests -B

# Create runtime image
FROM openjdk:17-jre-slim

WORKDIR /app

# Copy the JAR file
COPY --from=0 /app/target/resume-ai-backend-0.0.1-SNAPSHOT.jar app.jar

# Expose port
EXPOSE 8080

# Run the application
CMD ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
