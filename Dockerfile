FROM eclipse-temurin:21-jdk-alpine

# Рабочая директория
WORKDIR /minecraft

# Установка curl
RUN apk add --no-cache curl bash

# Скачиваем Fabric installer
RUN curl -OJ https://meta.fabricmc.net/v2/versions/loader/1.21.11/0.16.14/1.0.1/server/jar

# Переименовываем для удобства
RUN mv fabric-server-mc.*.jar fabric-server-launch.jar

# Принимаем EULA
RUN echo "eula=true" > eula.txt

# Создаём server.properties
RUN echo "server-port=25565\n\
online-mode=true\n\
max-players=20\n\
view-distance=10\n\
simulation-distance=10\n\
motd=Railway Minecraft Server\n\
difficulty=normal\n\
gamemode=survival\n\
enable-command-block=true\n\
spawn-protection=0" > server.properties

# Порт
EXPOSE 25565

# Запуск сервера
CMD ["java", "-Xmx2G", "-Xms1G", "-jar", "fabric-server-launch.jar", "nogui"]
