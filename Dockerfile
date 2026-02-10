FROM maven:3.9.4-eclipse-temurin-21 AS build
WORKDIR /app

# copy only what is needed for dependency resolution first
COPY pom.xml ./
COPY src ./src

# build the project
RUN mvn -B -DskipTests package

FROM eclipse-temurin:21-jre
WORKDIR /app

# copy the fat jar from the builder stage
COPY --from=build /app/target/Bajaj-API-keys-0.0.1-SNAPSHOT.jar /app/app.jar

ENV PORT=8080
EXPOSE 8080

ENTRYPOINT ["sh", "-c", "java -jar /app/app.jar"]
