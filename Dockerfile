FROM eclipse-temurin:21-jre-alpine

# Рабочая папка для запуска (НЕ на Volume!)
WORKDIR /app

RUN apk add --no-cache curl bash

# Fabric для 1.21.1 (которая в TLauncher = 1.21.11)
RUN curl -L -o fabric-server-launch.jar \
    "https://meta.fabricmc.net/v2/versions/loader/1.21.1/0.16.14/1.0.1/server/jar"

# Принимаем EULA
RUN echo "eula=true" > eula.txt

# Копируем скрипт запуска
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

# Папка для мира (сюда монтируется Volume)
RUN mkdir -p /minecraft

EXPOSE 25565

# Запуск через абсолютный путь
CMD ["/app/start.sh"]