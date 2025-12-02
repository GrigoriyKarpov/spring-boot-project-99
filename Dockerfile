# Build stage
FROM gradle:9.2.1-jdk17 AS build

WORKDIR /app

COPY . .

RUN gradle bootJar

# Runtime stage - используем полный JDK для надежности
FROM openjdk:17-jdk

WORKDIR /app

COPY --from=build /app/build/libs/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]