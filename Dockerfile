# Stage 1: Build the plugin
FROM maven:3.9.6-eclipse-temurin-17 as build

WORKDIR /app
COPY . .
RUN mvn clean install

# Stage 2: Build Jenkins image with the plugin
FROM jenkins/jenkins:lts-jdk17

# Switch to root to install plugin and adjust permissions
USER root

# Copy plugin from build stage
COPY --from=build /app/target/*.hpi /usr/share/jenkins/ref/plugins/

# Install additional plugin
RUN mkdir -p /usr/share/jenkins/ref/plugins \
 && chmod -R 777 /usr/share/jenkins/ref/plugins \
 && jenkins-plugin-cli --plugins configuration-as-code:1775.v810dc950b_514

# Switch back to Jenkins user
USER jenkins
