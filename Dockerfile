# Use an official Maven image with JDK 17
FROM maven:3.9.6-eclipse-temurin-17 AS build

# Set working directory
WORKDIR /app

# Copy the Maven project files
COPY . .

# Build the project (skip tests if needed)
RUN mvn clean install -DskipTests

# Final stage: Use a lightweight base if you want to copy the output elsewhere
# Or simply keep the build stage and use it directly (for debugging/testing)

# If you want to run Jenkins with your plugin, use this:
FROM jenkins/jenkins:lts-jdk17

# Copy the built HPI plugin into Jenkins plugins directory
COPY --from=build /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# Preinstall plugins (optional)
RUN jenkins-plugin-cli --plugins configuration-as-code:1700.vf343cd8990de

# Expose Jenkins port
EXPOSE 8080

# Jenkins runs by default
