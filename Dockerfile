FROM eclipse-temurin:17-jdk-alpine

WORKDIR /app

# Copy Maven wrapper
COPY mvnw mvnw.cmd ./
COPY .mvn .mvn

# Copy pom.xml
COPY pom.xml .

# Copy source code
COPY src src

# Build the application
RUN ./mvnw clean package -DskipTests

# Run the application
EXPOSE 8080
CMD ["java", "-jar", "target/pams-0.0.1-SNAPSHOT.jar"]