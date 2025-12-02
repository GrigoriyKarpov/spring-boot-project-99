FROM gradle:9.2.1-jdk17 AS builder

WORKDIR /app

COPY . .

RUN gradle bootJar

# Используем конкретный тег с версией
FROM openjdk:17.0.10-slim

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

CMD ["java", "-jar", "app.jar"]