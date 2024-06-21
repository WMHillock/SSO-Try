FROM amazoncorretto:11-alpine-jdk

EXPOSE 16666

COPY build/libs/user-service-0.0.1-SNAPSHOT.jar user-service.jar
COPY src/main/resources/Kerberos/* /etc/security/keytabs/

CMD ["java", "-jar", "soo-try.jar"]
