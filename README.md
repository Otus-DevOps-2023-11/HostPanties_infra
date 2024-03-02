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
<<<<<<< HEAD
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
