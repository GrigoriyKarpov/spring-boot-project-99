FROM gradle:8.7-jdk17 AS builder

WORKDIR /workspace
COPY . .
WORKDIR /workspace/app

RUN gradle build

RUN ls -la build/libs/

FROM eclipse-temurin:17-jre-alpine
WORKDIR /app
COPY --from=builder /workspace/app/build/libs/*.jar app.jar
EXPOSE 8080
CMD ["java", "-jar", "app.jar"]