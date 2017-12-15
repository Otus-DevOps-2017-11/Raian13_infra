# Raian13_infra

# ДЗ №5
## Конфигурация: 
Хост bastion, IP 35.198.71.201, внутренний IP 10.156.0.2
Хост someinternalhost, внутренний IP 10.156.0.3

## Multi-hop SSH oneliner:
ssh -t -A -i ~/.ssh/appuser appuser@35.198.71.201 ssh someinternalhost

## Доп. задание: multihop ssh + alias 
в ~/.ssh/config добавляем:
Host bastion
Hostname 35.198.71.201
User appuser

Host internalhost
Hostname 10.156.0.3
User appuser
ProxyCommand ssh -q bastion nc %h %p

После этого можно пройти на someinternalhost командой
ssh internalhost

 ## OpenVPN
 Настроено для запуска из консоли Ubuntu 16.04; запускается командой sudo openvpn --config otus.ovpn
