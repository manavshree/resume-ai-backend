# Use official Java 17 image
FROM openjdk:17-jdk-slim

# Install Maven
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy backend files
COPY resume-ai-backend/ ./resume-ai-backend/

# Set working directory to backend
WORKDIR /app/resume-ai-backend

# Make mvnw executable
RUN chmod +x mvnw

# Build the application
RUN ./mvnw clean package -DskipTests -B

# Move JAR to app root
RUN cp target/resume-ai-backend-0.0.1-SNAPSHOT.jar /app/app.jar

# Set working directory back to app root
WORKDIR /app

# Expose port
EXPOSE 8080

# Run the application
CMD ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
