FROM eclipse-temurin:21-jdk-alpine

WORKDIR /minecraft

RUN apk add --no-cache curl bash

# Скачиваем Fabric server launcher
RUN curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.21.11/0.16.14/1.0.1/server/jar
RUN mv fabric-server-mc.*.jar fabric-server-launch.jar

# Принимаем EULA
RUN echo "eula=true" > eula.txt

# server.properties — ОТКЛЮЧАЕМ online-mode
RUN printf "server-port=25565\n\
online-mode=false\n\
max-players=20\n\
view-distance=10\n\
simulation-distance=10\n\
motd=Railway Minecraft Server\n\
difficulty=normal\n\
gamemode=survival\n\
enable-command-block=true\n\
spawn-protection=0\n\
enforce-secure-profile=false\n" > server.properties

EXPOSE 25565

CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "fabric-server-launch.jar", "nogui"]
