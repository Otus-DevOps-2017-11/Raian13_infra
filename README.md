# Raian13_infra

Multi-hop SSH oneliner:
ssh -t -A -i ~/.ssh/appuser appuser@35.198.71.201 ssh someinternalhost

Доп. задание: 
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
