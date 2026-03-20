FROM eclipse-temurin:25
RUN mkdir /opt/spring-petclinic
COPY ./target/spring-petclinic-*.jar /opt/spring-petclinic/spring-petclinic.jar
CMD ["java", "-jar", "/opt/spring-petclinic/spring-petclinic.jar"]
