FROM maven:3.9 AS build

WORKDIR /var/www/spring-petclinic

COPY ./spring-petclinic /var/www/spring-petclinic

RUN rm -rf ./spring-petclinic/.git

RUN --mount=type=cache,target=/root/.m2 mvn -f /var/www/spring-petclinic/pom.xml clean package

FROM eclipse-temurin:17.0.12_7-jre-ubi9-minimal

COPY --from=build /var/www/spring-petclinic/target/*.jar app.jar

ENTRYPOINT ["java", "-jar", "app.jar"]
