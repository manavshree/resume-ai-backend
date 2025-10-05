# Step 1: Use official Java 17 image
FROM openjdk:17-jdk-slim

# Step 2: Install Maven (needed to build the app)
RUN apt-get update && apt-get install -y maven && rm -rf /var/lib/apt/lists/*

# Step 3: Set working directory inside container
WORKDIR /app

# Step 4: Copy Maven wrapper and pom.xml first for better caching
COPY mvnw mvnw.cmd pom.xml ./
COPY .mvn .mvn

# Step 5: Make mvnw executable
RUN chmod +x mvnw

# Step 6: Download dependencies (this layer will be cached if pom.xml doesn't change)
RUN ./mvnw dependency:go-offline -B

# Step 7: Copy source code
COPY src src

# Step 8: Build the app inside container
RUN ./mvnw clean package -DskipTests -B

# Step 9: Create a runtime image
FROM openjdk:17-jre-slim

WORKDIR /app

# Copy the JAR file from the build stage
COPY --from=0 /app/target/resume-ai-backend-0.0.1-SNAPSHOT.jar app.jar

# Step 10: Expose port
EXPOSE 8080

# Step 11: Run the built JAR with proper JVM settings for containers
CMD ["java", "-XX:+UseContainerSupport", "-XX:MaxRAMPercentage=75.0", "-jar", "app.jar"]
