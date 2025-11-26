# Stage 1: Build
FROM maven:3.9.9-eclipse-temurin-17 AS builder

# Arbeitsverzeichnis im Container
WORKDIR /app

# Maven Projektdateien kopieren
COPY pom.xml .
COPY src ./src

# Jar bauen
RUN mvn -B -ntp package


# Stage 2: Runtime
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Fertiges Jar aus Stage 1 uebernehmen
COPY --from=builder /app/target/*.jar /app/app.jar

# Webapp Port
EXPOSE 8080

# Startkommando
ENTRYPOINT ["java", "-jar", "/app/app.jar"]
