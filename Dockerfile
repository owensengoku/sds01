# Build runtime image.
FROM openjdk:18.0.2-jdk-slim
ENV UID=1000
ENV GID=1000
ENV UNAME=user
RUN groupadd -g $GID -o $UNAME && useradd -m -l -u $UID -g $GID -o -s /bin/bash $UNAME && chmod 700 /home/user
#####
COPY target/ /app/
EXPOSE 8080
WORKDIR /app
USER ${UID}:${GID}
# Starts java app with debugging server at port 8080.
CMD ["java", "-jar", "hello-world-1.0.0.jar"]
