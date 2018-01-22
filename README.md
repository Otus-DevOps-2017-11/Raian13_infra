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

# ДЗ №8 - Terraform основы
Файлы размещаются в каталоге terraform:  
main.tf - основной файл конфигурации;  
variables.tf и outputs.tf - input и output переменные;  
terraform.tfvars.example - пример файла со значениями переменных;  
files/puma.service, files/deploy.sh - файлы развертывания и запуска Puma как службы. 

# Запуск и проверка
terraform plan  
terraform apply -auto-approve 
<p>curl http://`terraform output app_external_ip`:9292</p>

# ДЗ №9 - Модули Terraform
## Описание
Terraform - модули для сервера приложений, сервера БД и файрволла

Примеры развертывания - в prod и stage.

В storage-bucket.tf - пример работы с модулем из реестра. 

Inputs:

| Name | Description | Default | Область применения |
| ---  | --- |  --- | --- |
| project | Project ID |  | Проект
| region | Region | europe-west3 | Проект 
| zone |Zone| europe-west3-b | Модули app, db
| public_key_path | Path to public key used for SSH access |  | Модули app, db
| app_disk_image | Disk image for reddit app | reddit-base-app | Модуль app
| db_disk_image | Disk image for reddit db | reddit-base-db | Модуль db
| instance_tag |Instance identifier |  | Модули app, db
| source_ranges | Firewall: allowed IP addresses | 0.0.0.0/0 |Модули app, vpc

Outputs:
| Name | Description | Default | Область применения |
| ---  | --- |  --- | --- |
| app_external_ip | App server external IP |  | Проект (наследуется из модуля app)
| db_external_ip | Database server external IP |  | Проект (наследуется из модуля db)

# ДЗ №10 - Ansible (основы)

Создан конфиг ansible.cfg, два варианта inventory - обычный и yaml варианты. 

# ДЗ №11 - Ansible playbooks

Подготовлены следующие ansible playbooks:
reddit-app-one-play.yml - все задачи в одном файле и в одном сценарии, при запуске нужно ограничивать по тегу и группе хостов:  
ansible-playbook reddit-app-one-play.yml --limit app --tags app-tag  

reddit-app-multiple-plays.yml - все задачи в одном файле и в множестве сценариев; при запуске достаточно ограничить только по тегу:
ansible-playbook reddit-app-multiple-plays.yml --tags app-tag

site.yml + app.yml + db.yml + deploy.yml - каждый сценарий в своем файле, есть объединяющий сценарий. Запускать можно как отдельные сценарии, так и сводный файл для полного цикла деплоя. 

packer-app.yml, packer-db.yml - плейбуки для Packer, заменяющие скрипты установки ПО для сервера приложений и сервера БД. Используются при подготовке образа с помощью Packer:
packer build -var-file=./variables-app.json app.json

