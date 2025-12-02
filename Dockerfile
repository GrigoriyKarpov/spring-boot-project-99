FROM gradle:9.2.1-jdk17 AS builder

# Устанавливаем рабочую директорию как /app (внутри контейнера)
WORKDIR /workspace

# Копируем ВСЕ содержимое репозитория
COPY . .

# Переходим в папку с проектом
WORKDIR /workspace/app

# Собираем проект
RUN gradle bootJar

# Проверяем что JAR создан
RUN ls -la build/libs/

# Создаем финальный образ
FROM eclipse-temurin:17-jre-alpine

WORKDIR /app

# Копируем JAR из builder стадии
COPY --from=builder /workspace/app/build/libs/*.jar app.jar

# Открываем порт
EXPOSE 8080

# Запускаем приложение
CMD ["java", "-jar", "app.jar"]