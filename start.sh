#!/bin/bash

SERVER_PORT=${PORT:-25565}

echo "============================================"
echo "  Minecraft Fabric 1.21.1"
echo "  Port: ${SERVER_PORT}"
echo "  World data: /minecraft"
echo "============================================"

# Переходим в папку данных (Volume)
cd /minecraft

# Копируем файлы запуска если их нет (первый запуск)
if [ ! -f "fabric-server-launch.jar" ]; then
    echo "Первый запуск — копируем файлы сервера..."
    cp /app/fabric-server-launch.jar /minecraft/
    cp /app/eula.txt /minecraft/
fi

# Создаём server.properties (всегда свежий, чтобы порт обновлялся)
cat > server.properties <<EOF
server-port=${SERVER_PORT}
query.port=${SERVER_PORT}
gamemode=survival
difficulty=normal
max-players=10
motd=Fabric Railway Server
level-name=world
online-mode=false
enable-query=false
view-distance=8
simulation-distance=6
spawn-protection=0
pvp=true
allow-nether=true
enable-command-block=true
network-compression-threshold=256
rate-limit=0
white-list=false
enforce-secure-profile=false
prevent-proxy-connections=false
server-ip=
EOF

echo "Запуск сервера..."

exec java \
    -Xms512M \
    -Xmx1024M \
    -XX:+UseG1GC \
    -jar fabric-server-launch.jar \
    --nogui \
    --port ${SERVER_PORT}