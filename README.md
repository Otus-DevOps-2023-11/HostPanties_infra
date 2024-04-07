# HostPanties_infra
HostPanties Infra repository

# Homework cloud-bastion
## ssh from local to private in one command
Без установки дополнительных пакетов почти во всех современных дистрибутивах Linux установлен доп. компонент для openssh, позволяющий "из коробки" подключиться к скрытому за NAT ssh серверу через Jump-server
```ssh -J user@bastion-ip user@internalhost```
## ssh from local to private ip /w alias (ext HW)
Так-же можно создать\изменить конфиг ssh ~/.ssh/config, включив туда строчки на подобии:
```
Host internalhost
    ProxyJump user@bastion-ip
```
## pritunl config explanation
bastion_IP = 84.201.133.98
someinternalhost_IP = 10.128.0.32

# Homework cloud-testapp
## testapp config explanation
testapp_IP = 158.160.29.48
testapp_port = 9292
## startup-script
```
yc compute instance create \
--name reddit-app-cl-init \
--hostname reddit-app02 \
--memory 4 \
--create-boot-disk image-folder-id=standard-images,image-family=ubuntu-2004-lts,size=10GB \
--network-interface subnet-name=default-ru-central1-b,nat-ip-version=ipv4 \
--metadata-from-file user-data=C:\Users\saushkinsa\Documents\VSCODE\HOMEWORK\HostPanties_infra\cloud-testapp\cloud-testapp.yaml \
--metadata serial-port-enable=1
```

# Homework terraform-1
## load-balancer manual config potential problems
- Масштабируемость
- Скорость масштабируемости
- Человеческий фактор при добавлении новых инстансов

# Homework terraform-2
## backend in bucket (s3 instance)
- Для каждой из окружений был создан файл backend.tf внутри директории окружения
- terraform.tfstate для каждого окружения был перенесен в отдельную директорию
- При одновременном запуске одной и той же конфигурации из двух консолей блокировка не будет происходить. Со-нно на каком то из шагов в каком либо из запущеных инстансов произойдет сбой

## reddit-app full deploy /w provisioners
- Были изменены два модуля: app & db
- В модуле app было добавлено:
    - выполнение скрипта deploy.
    - Изменение файла puma.service с текущим значением IP адресса хоста db
    - перезапуск демона systemd и сервиса puma
- В модуле db было добавлено:
    - изменение параметра bind_ip на внешний адрес
    - перезапуск сервиса mongodb

# Homework ansible-1
## rm -rf on ~/reddit /w ansible
- С помощью команды ```ansible app -m command -a 'rm -rf ~/reddit'``` мы удалили директорию reddit в которой находится репозиторий
- При следующем запуске плейбука на клонирование репозитория reddit ansible увидил отсутствие репозитория и скачал его
## static vs dynamic inventory
- В динамичном json инвентори необходимо указывать специальный раздел ```_meta :{"hostvars": {...}}```

# Homework ansible-2
## Сделано:
- Реализовано несколько подходов к построению playbook'a на примере reddit-monolith приложения:
  - Один плейбук, один сценарий
  - Один плейбук, несколько сценариев
  - Несколько плейбуков

- Реализовано создание образов packer'a с помощью ansible плагина

