FROM gradle:9.2.1-jdk17 AS builder

WORKDIR /workspace
COPY . .
WORKDIR /workspace/app

# Используем build вместо bootJar
RUN gradle build

# Проверяем что создалось
RUN ls -la build/libs/

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /workspace/app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]