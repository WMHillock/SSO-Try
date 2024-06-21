FROM amazoncorretto:11-alpine-jdk

EXPOSE 16666

COPY target/active-directory-0.0.1-SNAPSHOT.jar soo.jar
COPY src/main/resources/Kerberos/* /etc/security/keytabs/

CMD ["java", "-jar", "soo.jar"]
