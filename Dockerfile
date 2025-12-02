FROM gradle:9.2.1-jdk17 AS builder

WORKDIR /app

COPY . .

# Собираем Spring Boot JAR
RUN gradle bootJar

# Запускаем приложение из JAR
FROM openjdk:17-jdk-slim

WORKDIR /app

# Копируем собранный JAR из builder стадии
# Используем конкретное имя файла
COPY --from=builder /app/build/libs/*.jar app.jar

# Запускаем приложение
CMD ["java", "-jar", "app.jar"]

