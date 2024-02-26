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
bastion_IP = 178.154.203.121
someinternalhost_IP = 10.128.0.10
