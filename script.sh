#!/bin/bash

#Update
yum update -y
yum install -y inotify-tools

#Створення folder1 та folder2 в home dir
mkdir -p /root/folder1
mkdir -p /root/folder2

#Створення mover.service з конфігураціями для нашого сервісу
tee /etc/systemd/system/mover.service <<EOF
[Unit]
Description=Mover Service

[Service]
Type=simple
ExecStart=/root/move-script.sh
Restart=always

[Install]
WantedBy=multi-user.target
EOF

#Створення move-script.sh зі скріптом для перекидання файлу з folder1 в folder2
tee /root/move-script.sh <<EOF
#!/bin/bash

while true 
do 
    #if [ "$(ls -A /root/folder1)" ]; then 
        mv -fv /root/folder1/* /root/folder2
        echo "Files moved " >> /var/log/mover.log
    #fi  
    sleep 1 
done
EOF

#Надання можливості запускатись файлу move-script.sh
chmod +x /root/move-script.sh

#Перезавантаження демона
systemctl daemon-reload
#Запуск сервіса
systemctl start mover.service
#Встановлення автозапуску для сервіса
systemctl enable mover.service