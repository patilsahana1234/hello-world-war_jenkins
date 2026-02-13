# -------- Stage 1: Build WAR --------
FROM maven:3.8.2-openjdk-8 AS mavenbuilder

WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# -------- Stage 2: Tomcat Runtime --------
FROM tomcat:9.0-jre8-temurin

RUN rm -rf /usr/local/tomcat/webapps/*

COPY --from=mavenbuilder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war

EXPOSE 8080

CMD ["catalina.sh", "run"]
