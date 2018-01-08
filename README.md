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
 Настроено для запуска из консоли Ubuntu 16.04; запускается командой  
 sudo openvpn --config otus.ovpn

# ДЗ №6
Скрипты установки Ruby, MongoDB и деплоя 

## Доп. задание
Создание инстанса с использованием startup скрипта:  
gcloud compute instances create reddit-app --boot-disk-size=10GB --image-family ubuntu-1604-lts --image-project=ubuntu-os-cloud --machine-type=g1-small --tags puma-server --restart-on-failure --zone=europe-west3-b --metadata-from-file startup-script=homework6/startup.sh

Посмотреть логи startup скрипта  
gcloud compute --project=infra-1890171 instances get-serial-port-output reddit-app --zone=europe-west3-b


# ДЗ №7
ubuntu.json - конфиг-файл для packer; в секции variables определены все доступные при сборке переменные. Переменные со значением null - должны обязательно быть заданы при сборке образа.  
variables.json.example - пример файла переменных

Тестирование конфига: packer validate -var-file=./variables.json ubuntu16.json  
Сборка образа: packer build -var-file=./variables.json ubuntu16.json

# ДЗ №8
Файлы размещаются в каталоге terraform:  
main.tf - основной файл конфигурации;  
variables.tf и outputs.tf - input и output переменные;  
terraform.tfvars.example - пример файла со значениями переменных;  
files/puma.service, files/deploy.sh - файлы развертывания и запуска Puma как службы. 

# Запуск и проверка
terraform plan  
terraform apply -auto-approve 
<p>curl http://`terraform output app_external_ip`:9292</p>

# ДЗ №9 
## Описание
## Вопросы:
Слайды 25 и 27 домашнего задания: развертываю инфраструктуру и проверяю ее в консоли GoogleCloud - внешне все выглядит правильно. Меняю IP, на котором слушает MongoDB, с 127.0.0.1 на 0.0.0.0 и перезапускаю службу. Проверяю подключение с reddit-app - нет доступа к TCP/27017. Меняю в правиле файрволла allow-mongo-default способ фильтрации с тэга на сеть 0.0.0.0/0 - доступ к TCP/27017; получается, правило брандмауэра не отрабатывает по тэгу  (хотя тэг reddit-app на 
экземпляре reddit-app присутствует)