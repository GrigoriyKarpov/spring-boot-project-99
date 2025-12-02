FROM gradle:9.2.1-jdk17 AS builder

WORKDIR /app

COPY . .

RUN gradle bootJar

# Используем Eclipse Temurin - официальный дистрибутив OpenJDK
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

COPY --from=builder /app/build/libs/*.jar app.jar

CMD ["java", "-jar", "app.jar"]