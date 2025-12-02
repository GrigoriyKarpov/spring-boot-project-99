FROM gradle:9.2.1-jdk17 AS builder

WORKDIR /app

COPY . .

RUN gradle bootJar

# Запускаем приложение из JAR
FROM openjdk:17-slim
# или FROM eclipse-temurin:17-jre-alpine
# или FROM amazoncorretto:17-alpine

WORKDIR /app

# Копируем собранный JAR из builder стадии
COPY --from=builder /app/build/libs/*.jar app.jar

# Запускаем приложение
CMD ["java", "-jar", "app.jar"]