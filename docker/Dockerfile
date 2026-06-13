FROM eclipse-temurin:21-jre-jammy

COPY target/jb-hello-world-maven-*.jar /app.jar

COPY docker/start.sh /usr/bin/

ENTRYPOINT ["start.sh"]
