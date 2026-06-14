FROM eclipse-temurin:21-jre-alpine

WORKDIR /minecraft

# Утилиты
RUN apk add --no-cache curl bash

# Скачиваем Fabric installer
ARG FABRIC_INSTALLER_VERSION=1.0.1

RUN curl -OJ "https://meta.fabricmc.net/v2/versions/loader/1.21.1/0.16.14/1.0.1/server/jar" \
    && mv *.jar fabric-server-launch.jar

# Если не скачалось по API, используем прямую ссылку:
# RUN curl -L -o fabric-server-launch.jar \
#     "https://meta.fabricmc.net/v2/versions/loader/1.21.1/0.16.14/1.0.1/server/jar"

# Принимаем EULA
RUN echo "eula=true" > eula.txt

# Копируем файлы
COPY server.properties server.properties
COPY start.sh start.sh
RUN chmod +x start.sh

# Первый запуск — чтобы Fabric скачал ванильный сервер и сгенерировал файлы
RUN timeout 60 java -Xmx512M -jar fabric-server-launch.jar --nogui || true

EXPOSE 25565

CMD ["./start.sh"]